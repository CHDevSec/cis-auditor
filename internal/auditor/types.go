package auditor

// Config define onde ficam os perfis, os scripts de auditoria e a saída.
type Config struct {
	ProfilesDir string
	ScriptsDir  string // vazio = usa o scripts_dir do perfil
	ResultsDir  string
	// Workers é o número de scripts executados em paralelo (<= 0 usa o número de CPUs).
	Workers int
}

// Profile é um arquivo de configs/profiles.
type Profile struct {
	Title      string    `yaml:"title"`
	ScriptsDir string    `yaml:"scripts_dir"` // pasta dos scripts de auditoria, relativa à raiz do repo
	Controls   []Control `yaml:"controls"`
}

// Control é um controle CIS declarado num perfil YAML.
type Control struct {
	ID          string         `yaml:"id"`
	Category    string         `yaml:"category"`
	Description string         `yaml:"description"`
	Remediate   string         `yaml:"remediate"`
	Level       map[string]int `yaml:"level"`        // server / workstation
	Script      string         `yaml:"script"`       // opcional (legado)
	ScriptAudit string         `yaml:"script_audit"` // usado na auditoria
	ScriptFix   string         `yaml:"script_fix"`   // remediação correspondente
}

// Status possíveis de um controle.
const (
	StatusPass   = "PASS"   // o script encontrou a configuração esperada
	StatusFail   = "FAIL"   // o script encontrou um desvio
	StatusManual = "MANUAL" // o script só coletou informação: revisar à mão
	StatusError  = "ERROR"  // o script não pôde ser executado
)

// ControlResult é o resultado de um controle. Os nomes dos campos no JSON são mantidos
// (ID, Status, ...) para não quebrar quem já consome a saída.
type ControlResult struct {
	ID          string
	Category    string
	Description string
	Status      string
	Remediation string
	Details     string
	FixScript   string `json:",omitempty"` // caminho do script de remediação, se existir
}

// Report é o resultado completo de uma execução.
type Report struct {
	Profile        string          `json:"profile"`
	MachineType    string          `json:"machine_type"`
	Level          int             `json:"level"`
	Hostname       string          `json:"hostname"`
	Timestamp      string          `json:"timestamp"` // RFC 3339
	Total          int             `json:"total"`
	Passed         int             `json:"passed"`
	Failed         int             `json:"failed"`
	Manual         int             `json:"manual"`
	Errors         int             `json:"errors"`
	ResultsDir     string          `json:"-"`
	ControlResults []ControlResult `json:"controls"`
}
