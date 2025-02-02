package checks

import (
	"database/sql"
	"fmt"
	"sbom/health/config"

	_ "github.com/lib/pq"
)

type PostgresCheck struct {
	config *config.Config
}

func NewPostgresCheck(cfg *config.Config) *PostgresCheck {
	return &PostgresCheck{config: cfg}
}

func (c *PostgresCheck) Check() error {
	dsn := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable",
		c.config.Postgres.User,
		c.config.Postgres.Password,
		c.config.Postgres.Host,
		c.config.Postgres.Port,
		c.config.Postgres.Database,
	)

	db, err := sql.Open("postgres", dsn)
	if err != nil {
		return err
	}

	defer db.Close()
	return db.Ping()
}

func (c *PostgresCheck) Name() string {
	return "PostgreSQL"
}
