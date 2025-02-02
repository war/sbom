package checks

type HealthCheck interface {
	Check() error
	Name() string
}
