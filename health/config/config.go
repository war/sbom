package config

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/joho/godotenv"
)

type HostPort struct {
	Host string
	Port string
}

type Credentials struct {
	User     string
	Password string
}

type DatabaseConfig struct {
	HostPort
	Credentials
	Database string
}

type MinioConfig struct {
	HostPort
	Credentials
}

type Config struct {
	Postgres      DatabaseConfig
	Elasticsearch HostPort
	Minio         MinioConfig
	API           HostPort
	Web           HostPort
	Parser        HostPort
}

func LoadConfig() (*Config, error) {
	envPath, err := findEnvFile()
	if err != nil {
		return nil, fmt.Errorf("error finding .env file: %w", err)
	}

	err = godotenv.Load(envPath)
	if err != nil {
		return nil, fmt.Errorf("error loading .env file: %w", err)
	}

	config := &Config{
		Postgres: DatabaseConfig{
			HostPort: HostPort{
				Host: getEnvOrDefault("POSTGRES_HOST", "localhost"),
				Port: getEnvOrDefault("POSTGRES_PORT", "5432"),
			},
			Credentials: Credentials{
				User:     getEnvOrDefault("POSTGRES_USER", "sbom_user"),
				Password: getEnvOrDefault("POSTGRES_PASSWORD", "sbom_password"),
			},
			Database: getEnvOrDefault("POSTGRES_DB", "sbom_db"),
		},
		Elasticsearch: HostPort{
			Host: getEnvOrDefault("ELASTICSEARCH_HOST", "localhost"),
			Port: getEnvOrDefault("ELASTICSEARCH_PORT", "9200"),
		},
		Minio: MinioConfig{
			HostPort: HostPort{
				Host: getEnvOrDefault("MINIO_HOST", "localhost"),
				Port: getEnvOrDefault("MINIO_PORT", "9000"),
			},
			Credentials: Credentials{
				User:     getEnvOrDefault("MINIO_ROOT_USER", "minio_user"),
				Password: getEnvOrDefault("MINIO_ROOT_PASSWORD", "minio_password"),
			},
		},
		API: HostPort{
			Host: getEnvOrDefault("API_HOST", "localhost"),
			Port: getEnvOrDefault("API_PORT", "8080"),
		},
		Web: HostPort{
			Host: getEnvOrDefault("WEB_HOST", "localhost"),
			Port: getEnvOrDefault("WEB_PORT", "3000"),
		},
		Parser: HostPort{
			Host: getEnvOrDefault("PARSER_HOST", "localhost"),
			Port: getEnvOrDefault("PARSER_PORT", "8081"),
		},
	}

	return config, nil
}

func getEnvOrDefault(key, defaultValue string) string {
	if value, exists := os.LookupEnv(key); exists {
		return value
	}

	return defaultValue
}

func findEnvFile() (string, error) {
	dir, err := os.Getwd()
	if err != nil {
		return "", err
	}

	for {
		envPath := filepath.Join(dir, ".env")
		if _, err := os.Stat(envPath); err == nil {
			return envPath, nil
		}

		parent := filepath.Dir(dir)
		if parent == dir {
			return "", fmt.Errorf(".env file not found")
		}

		dir = parent
	}
}
