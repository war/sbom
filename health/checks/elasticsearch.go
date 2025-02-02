package checks

import (
	"fmt"
	"sbom/health/config"

	"github.com/elastic/go-elasticsearch/v8"
)

type ElasticsearchCheck struct {
	config *config.Config
}

func NewElasticsearchCheck(cfg *config.Config) *ElasticsearchCheck {
	return &ElasticsearchCheck{config: cfg}
}

func (c *ElasticsearchCheck) Check() error {
	address := fmt.Sprintf("http://%s:%s",
		c.config.Elasticsearch.Host,
		c.config.Elasticsearch.Port,
	)

	cfg := elasticsearch.Config{
		Addresses: []string{address},
	}

	es, err := elasticsearch.NewClient(cfg)
	if err != nil {
		return err
	}

	res, err := es.Info()
	if err != nil {
		return err
	}

	defer res.Body.Close()
	return nil
}

func (c *ElasticsearchCheck) Name() string {
	return "Elasticsearch"
}
