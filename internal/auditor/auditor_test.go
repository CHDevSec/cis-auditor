package auditor

import (
	"os"
	"path/filepath"
	"testing"
)

func TestParseAuditOutput(t *testing.T) {
	cases := []struct {
		name, output, status, details string
	}{
		{"fase01 pass", "Verificando ASLR...\n** PASS **", StatusPass, ""},
		{"fase01 fail com detalhe", "Verificando...\n** FAIL **\n- ASLR desabilitado. Valor: 0", StatusFail, "ASLR desabilitado. Valor: 0"},
		{"emoji pass", "Verificando se o autofs está instalado...\n✅ autofs não está instalado", StatusPass, ""},
		{"check mark pass", "✔ IPv4 forwarding desabilitado\n✔ IPv6 forwarding desabilitado", StatusPass, ""},
		{"uma falha vence", "✔ IPv4 forwarding desabilitado\n✘ IPv6 forwarding habilitado", StatusFail, "IPv6 forwarding habilitado"},
		{"cruz pesada", "✖ UFW não está instalado.", StatusFail, "UFW não está instalado."},
		{"só informação", "Outgoing: allow (outgoing)", StatusManual, "Outgoing: allow (outgoing)"},
		{"sem saída", "", StatusManual, "O script não retornou saída: revisar manualmente."},
	}
	for _, c := range cases {
		t.Run(c.name, func(t *testing.T) {
			status, details := parseAuditOutput(c.output)
			if status != c.status || details != c.details {
				t.Fatalf("got (%q, %q), want (%q, %q)", status, details, c.status, c.details)
			}
		})
	}
}

// Um script que termina com código != 0 (ex.: grep sem resultado) não é ERROR.
func TestRunProfile(t *testing.T) {
	root := t.TempDir()
	profiles := filepath.Join(root, "profiles")
	audit := filepath.Join(root, "fase", "auditoria")
	fix := filepath.Join(root, "fase", "remediacao")
	for _, d := range []string{profiles, audit, fix} {
		if err := os.MkdirAll(d, 0o755); err != nil {
			t.Fatal(err)
		}
	}
	write := func(p, s string) {
		if err := os.WriteFile(p, []byte(s), 0o644); err != nil {
			t.Fatal(err)
		}
	}
	write(filepath.Join(profiles, "p.yaml"), `controls:
  - id: "1.1"
    description: ok
    level: {server: 1}
    script_audit: ok_audit.sh
    script_fix: ok_fix.sh
  - id: "1.2"
    description: falha com exit 1
    level: {server: 1}
    script_audit: bad_audit.sh
  - id: "1.3"
    description: só nível 2
    level: {server: 2}
    script_audit: ok_audit.sh
  - id: "1.4"
    description: script ausente
    level: {server: 1}
    script_audit: nao_existe.sh
`)
	write(filepath.Join(audit, "ok_audit.sh"), "echo '✅ tudo certo'\n")
	write(filepath.Join(audit, "bad_audit.sh"), "echo '❌ serviço ativo'\nexit 1\n")
	write(filepath.Join(fix, "ok_fix.sh"), "true\n")

	a, err := New(Config{ProfilesDir: profiles, ScriptsDir: audit, ResultsDir: filepath.Join(root, "out"), Workers: 2})
	if err != nil {
		t.Fatal(err)
	}
	r, err := a.Run("p", "server", 1)
	if err != nil {
		t.Fatal(err)
	}
	if r.Total != 2 || r.Passed != 1 || r.Failed != 1 || r.Errors != 0 {
		t.Fatalf("resumo inesperado: %+v", r)
	}
	if r.ControlResults[0].ID != "1.1" || r.ControlResults[1].ID != "1.2" {
		t.Fatalf("ordem do perfil não foi mantida: %+v", r.ControlResults)
	}
	if r.ControlResults[0].FixScript == "" || r.ControlResults[1].FixScript != "" {
		t.Fatalf("FixScript inesperado: %+v", r.ControlResults)
	}
	if err := SaveReportJSON(r, filepath.Join(root, "out", "r.json")); err != nil {
		t.Fatal(err)
	}
}

func TestInvalidMachineType(t *testing.T) {
	a, _ := New(Config{ResultsDir: t.TempDir()})
	if _, err := a.Run("x", "laptop", 1); err == nil {
		t.Fatal("esperava erro para tipo de máquina inválido")
	}
}
