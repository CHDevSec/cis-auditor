#!/usr/bin/env python3
import json
import os
from datetime import datetime
from pathlib import Path

results_dir = "results"
json_files = sorted(
    [f for f in os.listdir(results_dir) if f.endswith(".json")],
    key=lambda x: os.path.getmtime(os.path.join(results_dir, x)),
    reverse=True
)

if not json_files:
    print("Nenhum arquivo JSON encontrado em 'results/'")
    exit(1)

latest_json_path = os.path.join(results_dir, json_files[0])

with open(latest_json_path, "r") as f:
    try:
        results = json.load(f)
        if not isinstance(results, list):
            raise ValueError("Formato inesperado: esperado uma lista de resultados.")
    except Exception as e:
        print(f"Erro ao carregar JSON: {e}")
        exit(1)

basename = Path(latest_json_path).stem
hostname = basename.split("-")[2] if "-" in basename else "unknown"

pass_count = sum(1 for r in results if r.get("Status") == "PASS")
fail_count = sum(1 for r in results if r.get("Status") == "FAIL")
error_count = sum(1 for r in results if r.get("Status") not in ("PASS", "FAIL"))

rows_html = ""
for r in results:
    status_class = {
        "PASS": "status-pass",
        "FAIL": "status-fail"
    }.get(r.get("Status", ""), "status-error")

    row = f"""
    <tr>
        <td>{r.get('Category', '')}</td>
        <td>{r.get('ID', '')}</td>
        <td class="{status_class}">{r.get('Status', '')}</td>
        <td>{r.get('Description', '')}<div class="details">{r.get('Details', '')}</div></td>
        <td><div class="remediation">{r.get('Remediation', 'N/A')}</div></td>
    </tr>
    """
    rows_html += row

html_content = f"""<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Relatório CIS - {hostname}</title>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; }}
        .header {{ border-bottom: 1px solid #eee; margin-bottom: 20px; }}
        .summary {{ background: #f8f9fa; padding: 15px; margin-bottom: 20px; }}
        .passed {{ color: #28a745; font-weight: bold; }}
        .failed {{ color: #dc3545; font-weight: bold; }}
        .error {{ color: #ffc107; font-weight: bold; }}
        table {{ width: 100%; border-collapse: collapse; }}
        th, td {{ padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd; }}
        th {{ background-color: #2c3e50; color: white; }}
        .status-pass {{ color: #28a745; }}
        .status-fail {{ color: #dc3545; }}
        .status-error {{ color: #ffc107; }}
        .remediation {{ font-family: monospace; background: #f8f9fa; padding: 5px; }}
        .details {{ font-size: 0.9em; color: #666; }}
    </style>
</head>
<body>
    <div class="header">
        <h1>Relatório de Auditoria CIS</h1>
        <p><strong>Hostname:</strong> {hostname} | <strong>Data:</strong> {datetime.now().strftime('%d/%m/%Y %H:%M:%S')}</p>
    </div>
    <div class="summary">
        <h3>Resumo</h3>
        <p><span class="passed">✓ Passaram: {pass_count}</span> | 
           <span class="failed">✗ Falharam: {fail_count}</span> |
           <span class="error">⚠ Erros: {error_count}</span></p>
    </div>
    <h3>Detalhes da Auditoria</h3>
    <table>
        <thead>
            <tr>
                <th>Categoria</th>
                <th>CIS ID</th>
                <th>Status</th>
                <th>Descrição</th>
                <th>Correção</th>
            </tr>
        </thead>
        <tbody>
            {rows_html}
        </tbody>
    </table>
</body>
</html>"""

html_filename = f"cis-audit-report.{hostname}.html"
with open(os.path.join(results_dir, html_filename), "w") as f:
    f.write(html_content)

print(f"✅ Relatório gerado: {os.path.join(results_dir, html_filename)}")
