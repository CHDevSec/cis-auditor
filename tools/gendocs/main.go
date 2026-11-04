// gendocs gera a documentação dos controles a partir dos perfis YAML:
// docs/CONTROLS.md e o README.md de cada pasta de scripts. Rode com `make docs`.
package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"sort"
	"strings"

	"cis-auditor/internal/auditor"
)

type entry struct {
	name string
	prof *auditor.Profile
}

func main() {
	files, err := filepath.Glob("configs/profiles/*.yaml")
	if err != nil || len(files) == 0 {
		log.Fatal("nenhum perfil em configs/profiles (rode na raiz do repositório)")
	}
	sort.Strings(files)

	var all []entry
	total := 0
	for _, f := range files {
		p, err := auditor.LoadProfile(f)
		if err != nil {
			log.Fatal(err)
		}
		name := strings.TrimSuffix(filepath.Base(f), ".yaml")
		all = append(all, entry{name, p})
		total += len(p.Controls)
		if p.ScriptsDir != "" {
			write(filepath.Join(filepath.Dir(p.ScriptsDir), "README.md"), folderReadme(name, p))
		}
	}

	var b strings.Builder
	b.WriteString("<!-- gerado por `make docs` (tools/gendocs) a partir de configs/profiles — não edite à mão -->\n")
	b.WriteString("# Controles CIS cobertos\n\n")
	fmt.Fprintf(&b, "**%d controles** do CIS Ubuntu Linux 22.04 LTS Benchmark em **%d perfis**. Todo controle tem um script de auditoria (só leitura) e um de remediação.\n\n", total, len(all))
	b.WriteString("| Perfil | Controles | Comando |\n|---|---:|---|\n")
	for _, e := range all {
		fmt.Fprintf(&b, "| [%s](#%s) | %d | `make %s` |\n", e.prof.Title, anchor(e.prof.Title), len(e.prof.Controls), makeTarget(e.name))
	}
	for _, e := range all {
		fmt.Fprintf(&b, "\n## %s\n\nPerfil `%s` · scripts em [`%s`](../%s)\n\n", e.prof.Title, e.name, filepath.Dir(e.prof.ScriptsDir), filepath.Dir(e.prof.ScriptsDir))
		b.WriteString(table(e.prof, "docs"))
	}
	write("docs/CONTROLS.md", b.String())
}

func folderReadme(name string, p *auditor.Profile) string {
	dir := filepath.Dir(p.ScriptsDir)
	var b strings.Builder
	b.WriteString("<!-- gerado por `make docs` (tools/gendocs) a partir de configs/profiles — não edite à mão -->\n")
	fmt.Fprintf(&b, "# %s\n\nPerfil [`%s`](%s) · %d controles.\n\n", p.Title, name, rel(dir, "configs/profiles/"+name+".yaml"), len(p.Controls))
	fmt.Fprintf(&b, "```bash\nmake %s                     # audita o perfil e gera o HTML em results/\nmake audit_id ID=%s           # audita um controle\nsudo make fix_id ID=%s        # aplica a remediação de um controle\n```\n\n", makeTarget(name), p.Controls[0].ID, p.Controls[0].ID)
	b.WriteString("> `auditoria/` só lê o sistema. `remediacao/` **altera** o sistema: leia o script e teste numa VM antes de usar em produção.\n\n")
	b.WriteString(table(p, dir))
	return b.String()
}

// table lista os controles com links relativos à pasta docDir (onde o documento fica).
func table(p *auditor.Profile, docDir string) string {
	var b strings.Builder
	auditDir := p.ScriptsDir
	fixDir := filepath.Join(filepath.Dir(p.ScriptsDir), "remediacao")
	b.WriteString("| ID | Controle | Categoria | Server | Workstation | Auditoria | Remediação |\n|---|---|---|:-:|:-:|:-:|:-:|\n")
	for _, c := range p.Controls {
		fix := "—"
		if c.ScriptFix != "" {
			if _, err := os.Stat(filepath.Join(fixDir, c.ScriptFix)); err == nil {
				fix = fmt.Sprintf("[fix](%s)", rel(docDir, filepath.Join(fixDir, c.ScriptFix)))
			}
		}
		fmt.Fprintf(&b, "| %s | %s | %s | %s | %s | [audit](%s) | %s |\n",
			c.ID, c.Description, c.Category, lvl(c, "server"), lvl(c, "workstation"), rel(docDir, filepath.Join(auditDir, c.ScriptAudit)), fix)
	}
	return b.String()
}

func lvl(c auditor.Control, t string) string {
	if l, ok := c.Level[t]; ok {
		return fmt.Sprintf("L%d", l)
	}
	return "—"
}

func makeTarget(profile string) string {
	switch t := strings.TrimPrefix(profile, "ubuntu_22.04_"); t {
	case "fase01":
		return "audit"
	case "fase02_firewall_ufw":
		return "audit_fase02_ufw"
	default:
		return "audit_" + t
	}
}

func anchor(title string) string {
	var b strings.Builder
	for _, r := range strings.ToLower(title) {
		switch {
		case r == ' ':
			b.WriteRune('-')
		case r == '-' || r == '_' || r >= '0' && r <= '9' || r >= 'a' && r <= 'z' || r > 127 && r != '—':
			b.WriteRune(r)
		}
	}
	return b.String()
}

// rel devolve o caminho de target visto a partir da pasta from (ambos relativos à raiz).
func rel(from, target string) string {
	r, err := filepath.Rel(from, target)
	if err != nil {
		return target
	}
	return r
}

func write(path, content string) {
	if err := os.WriteFile(path, []byte(content), 0o644); err != nil {
		log.Fatal(err)
	}
	fmt.Println("✔", path)
}
