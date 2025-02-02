package checks

import (
	"fmt"
	"net/http"
	"time"
)

type HTTPCheck struct {
	ServiceName string
	URL         string
	Timeout     time.Duration
}

func NewHTTPCheck(serviceName, url string) *HTTPCheck {
	return &HTTPCheck{
		ServiceName: serviceName,
		URL:         url,
		Timeout:     5 * time.Second,
	}
}

func (c *HTTPCheck) Check() error {
	client := http.Client{
		Timeout: c.Timeout,
	}

	resp, err := client.Get(c.URL)
	if err != nil {
		return err
	}

	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("status code %d", resp.StatusCode)
	}

	return nil
}

func (c *HTTPCheck) Name() string {
	return c.ServiceName
}
