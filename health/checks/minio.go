package checks

import (
	"context"
	"fmt"
	"sbom/health/config"

	"github.com/minio/minio-go/v7"
	"github.com/minio/minio-go/v7/pkg/credentials"
)

type MinioCheck struct {
	config *config.Config
}

func NewMinioCheck(cfg *config.Config) *MinioCheck {
	return &MinioCheck{config: cfg}
}

func (c *MinioCheck) Check() error {
	endpoint := fmt.Sprintf("%s:%s",
		c.config.Minio.Host,
		c.config.Minio.Port,
	)

	minioClient, err := minio.New(endpoint, &minio.Options{
		Creds:  credentials.NewStaticV4(c.config.Minio.User, c.config.Minio.Password, ""),
		Secure: false,
	})

	if err != nil {
		return err
	}

	_, err = minioClient.ListBuckets(context.Background())
	return err
}

func (c *MinioCheck) Name() string {
	return "MinIO"
}
