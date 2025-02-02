package main

import (
	"fmt"
	"log"
	"sbom/health/checks"
	"sbom/health/config"

	"github.com/fatih/color"
)

var (
	success = color.New(color.FgGreen).SprintFunc()
	fail    = color.New(color.FgRed).SprintFunc()
	info    = color.New(color.FgCyan).SprintFunc()
)

func main() {
	fmt.Println(info("Starting health checks..."))

	cfg, err := config.LoadConfig()
	if err != nil {
		log.Fatalf("Failed to load config: %v", err)
	}

	healthChecks := []checks.HealthCheck{
		checks.NewPostgresCheck(cfg),
		checks.NewElasticsearchCheck(cfg),
		checks.NewMinioCheck(cfg),
		checks.NewHTTPCheck("API", fmt.Sprintf("http://%s:%s/health", cfg.API.Host, cfg.API.Port)),
		checks.NewHTTPCheck("Parser", fmt.Sprintf("http://%s:%s/health", cfg.Parser.Host, cfg.Parser.Port)),
		checks.NewHTTPCheck("Web", fmt.Sprintf("http://%s:%s", cfg.Web.Host, cfg.Web.Port)),
	}

	for _, check := range healthChecks {
		err := check.Check()
		if err != nil {
			fmt.Printf("%s: %s - %v\n", check.Name(), fail("✗"), err)
			continue
		}

		fmt.Printf("%s: %s\n", check.Name(), success("✓"))
	}
}
