#!/usr/bin/env python3
"""Gera o relatório HTML a partir de um JSON do cis-auditor.

Uso:
    python3 scripts/generate_report.py                      # JSON mais recente em results/
                                                            # → results/cis-audit-report-<perfil>.html
    python3 scripts/generate_report.py results/x.json       # um JSON específico
    python3 scripts/generate_report.py x.json -o saida.html

Aceita o formato atual (objeto com metadados e "controls") e o antigo (lista de controles).
Sem dependências além da biblioteca padrão.
"""
import argparse
import glob
import html
import json
import os
import sys
from datetime import datetime

STATUS = {
    "PASS": ("Aprovado", "pass"),
    "FAIL": ("Falhou", "fail"),
    "MANUAL": ("Revisão manual", "manual"),
    "ERROR": ("Erro", "error"),
}


def latest_json(results_dir):
    files = glob.glob(os.path.join(results_dir, "audit-results-*.json"))
    if not files:
        sys.exit(f"Nenhum arquivo audit-results-*.json encontrado em '{results_dir}/'. Rode uma auditoria antes (make audit).")
    return max(files, key=os.path.getmtime)


def load(path):
    with open(path, encoding="utf-8") as f:
        data = json.load(f)
    if isinstance(data, list):  # formato antigo: só a lista de controles
        name = os.path.basename(path)[len("audit-results-"):-len(".json")]
        host = name.rsplit("-", 2)[0] if name.count("-") >= 2 else "desconhecido"
        data = {"profile": "—", "machine_type": "—", "level": "—", "hostname": host,
                "timestamp": datetime.fromtimestamp(os.path.getmtime(path)).isoformat(timespec="seconds"),
                "controls": data}
    controls = data.get("controls") or []
    for key, status in (("passed", "PASS"), ("failed", "FAIL"), ("manual", "MANUAL"), ("errors", "ERROR")):
        data[key] = sum(1 for c in controls if c.get("Status") == status)
    data["total"] = len(controls)
    return data


def fmt_time(ts):
    try:
        return datetime.fromisoformat(ts).strftime("%d/%m/%Y %H:%M:%S")
    except (TypeError, ValueError):
        return ts or "—"


def render(data):
    e = html.escape
    controls = data["controls"]
    automated = data["passed"] + data["failed"]
    score = round(100 * data["passed"] / automated) if automated else 0

    rows = []
    for c in controls:
        label, cls = STATUS.get(c.get("Status", ""), ("Erro", "error"))
        details = e(c.get("Details") or "")
        if cls != "manual":
            details = details.replace("\n", "<br>")
        fix = c.get("FixScript")
        fix_html = f'<code>sudo bash {e(fix)}</code>' if fix else '<span class="muted">sem script</span>'
        hint = e(c.get("Remediation") or "").lstrip("# ")
        rows.append(f"""
      <tr class="row-{cls}">
        <td class="id">{e(c.get('ID', ''))}</td>
        <td><span class="badge {cls}">{label}</span></td>
        <td><div class="desc">{e(c.get('Description', ''))}</div><div class="cat">{e(c.get('Category') or '')}</div>{f'<div class="details">{details}</div>' if details else ''}</td>
        <td>{fix_html}{f'<div class="hint">{hint}</div>' if hint else ''}</td>
      </tr>""")

    return f"""<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Relatório CIS — {e(str(data.get('hostname', '')))}</title>
<style>
  :root {{ --bg:#f6f7f9; --card:#fff; --ink:#1d2330; --muted:#6b7280; --line:#e5e7eb;
          --pass:#15803d; --fail:#b91c1c; --manual:#1d4ed8; --error:#b45309; }}
  * {{ box-sizing:border-box; }}
  body {{ margin:0; font:15px/1.5 system-ui,-apple-system,"Segoe UI",Roboto,sans-serif; color:var(--ink); background:var(--bg); }}
  header {{ background:#111827; color:#f9fafb; padding:28px 40px; }}
  header h1 {{ margin:0 0 6px; font-size:22px; }}
  header p {{ margin:0; color:#cbd5e1; font-size:14px; }}
  main {{ padding:28px 40px 48px; max-width:1280px; margin:0 auto; }}
  .cards {{ display:grid; grid-template-columns:repeat(auto-fit,minmax(150px,1fr)); gap:14px; margin-bottom:28px; }}
  .card {{ background:var(--card); border:1px solid var(--line); border-radius:10px; padding:16px 18px; }}
  .card b {{ display:block; font-size:28px; line-height:1.1; }}
  .card span {{ color:var(--muted); font-size:13px; }}
  .card.score {{ color:{'var(--pass)' if score >= 80 else 'var(--error)' if score >= 50 else 'var(--fail)'}; }}
  .card.score span {{ color:var(--muted); }}
  .bar {{ height:8px; border-radius:4px; background:var(--line); overflow:hidden; margin-top:10px; }}
  .bar i {{ display:block; height:100%; width:{score}%; background:currentColor; }}
  table {{ width:100%; border-collapse:collapse; background:var(--card); border:1px solid var(--line); border-radius:10px; overflow:hidden; }}
  th {{ text-align:left; font-size:12px; text-transform:uppercase; letter-spacing:.04em; color:var(--muted); background:#f9fafb; padding:10px 14px; border-bottom:1px solid var(--line); }}
  td {{ padding:12px 14px; border-bottom:1px solid var(--line); vertical-align:top; }}
  tr:last-child td {{ border-bottom:0; }}
  td.id {{ font-family:ui-monospace,monospace; white-space:nowrap; }}
  .badge {{ display:inline-block; padding:2px 10px; border-radius:999px; font-size:12px; font-weight:600; white-space:nowrap; color:#fff; }}
  .badge.pass {{ background:var(--pass); }} .badge.fail {{ background:var(--fail); }}
  .badge.manual {{ background:var(--manual); }} .badge.error {{ background:var(--error); }}
  .cat {{ color:var(--muted); font-size:13px; }}
  .details {{ margin-top:6px; font-size:13px; color:#374151; background:#f9fafb; border-left:3px solid var(--line); padding:6px 10px; }}
  .row-fail .details {{ border-left-color:var(--fail); }}
  .row-manual .details {{ border-left-color:var(--manual); font:12px/1.45 ui-monospace,monospace; max-height:180px; overflow:auto; white-space:pre; }}
  code {{ font:12px ui-monospace,monospace; background:#f3f4f6; padding:3px 6px; border-radius:4px; word-break:break-all; }}
  .hint {{ margin-top:6px; color:var(--muted); font-size:12px; }}
  .muted {{ color:var(--muted); font-size:13px; }}
  footer {{ color:var(--muted); font-size:12px; margin-top:20px; }}
</style>
</head>
<body>
<header>
  <h1>Relatório de Auditoria CIS</h1>
  <p>Host <b>{e(str(data.get('hostname', '')))}</b> · Perfil <b>{e(str(data.get('profile', '')))}</b> · Tipo {e(str(data.get('machine_type', '')))} · Nível {e(str(data.get('level', '')))} · {e(fmt_time(data.get('timestamp')))}</p>
</header>
<main>
  <section class="cards">
    <div class="card score"><b>{score}%</b><span>conformidade dos controles automatizados</span><div class="bar"><i></i></div></div>
    <div class="card"><b>{data['total']}</b><span>controles verificados</span></div>
    <div class="card"><b style="color:var(--pass)">{data['passed']}</b><span>aprovados</span></div>
    <div class="card"><b style="color:var(--fail)">{data['failed']}</b><span>falharam</span></div>
    <div class="card"><b style="color:var(--manual)">{data['manual']}</b><span>revisão manual</span></div>
    <div class="card"><b style="color:var(--error)">{data['errors']}</b><span>erros de execução</span></div>
  </section>
  <table>
    <thead><tr><th>CIS ID</th><th>Status</th><th>Controle</th><th>Remediação</th></tr></thead>
    <tbody>{''.join(rows)}
    </tbody>
  </table>
  <footer>Gerado por cis-auditor · revise cada remediação antes de aplicar em produção.</footer>
</main>
</body>
</html>
"""


def main():
    ap = argparse.ArgumentParser(description="Gera o relatório HTML do cis-auditor a partir do JSON.")
    ap.add_argument("json", nargs="?", help="JSON de resultado (padrão: o mais recente em --results-dir)")
    ap.add_argument("--results-dir", default="results")
    ap.add_argument("-o", "--output", help="HTML de saída (padrão: <results-dir>/cis-audit-report-<perfil>.html)")
    args = ap.parse_args()

    path = args.json or latest_json(args.results_dir)
    data = load(path)
    profile = str(data.get("profile") or "").strip("—") or "auditoria"
    out = args.output or os.path.join(args.results_dir, f"cis-audit-report-{profile}.html")
    os.makedirs(os.path.dirname(out) or ".", exist_ok=True)
    with open(out, "w", encoding="utf-8") as f:
        f.write(render(data))
    print(f"✅ Relatório HTML gerado em: {out} (a partir de {path})")


if __name__ == "__main__":
    main()
