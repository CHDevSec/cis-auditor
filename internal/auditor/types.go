package auditor

type Config struct {
	ProfilesDir string
	ScriptsDir  string
	ResultsDir  string
}

type Control struct {
	ID          string         `yaml:"id"`
	Category    string         `yaml:"category"`
	Description string         `yaml:"description"`
	Remediate   string         `yaml:"remediate"`
	Level       map[string]int `yaml:"level"`           // Server/Workstation
	Script      string         `yaml:"script"`          // opcional
	ScriptAudit string         `yaml:"script_audit"`    // usado na auditoria
	ScriptFix   string         `yaml:"script_fix"`      // usado para remediação futura
}

type ControlResult struct {
	ID          string
	Category    string
	Description string
	Status      string // "PASS", "FAIL", "ERROR"
	Remediation string
	Details     string
}

type Report struct {
	Profile        string
	MachineType    string
	Level          int
	Total          int
	Passed         int
	Failed         int
	Errors         int
	ResultsDir     string
	Timestamp      string
	ControlResults []ControlResult
}
