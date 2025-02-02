package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func setupRouter() *gin.Engine {
	r := gin.Default()

	// basic health check endpoint
	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"status": "ok",
		})
	})

	// API v1 group
	v1 := r.Group("/api/v1")
	{
		sbom := v1.Group("/sbom")
		{
			sbom.POST("/upload", handleSBOMUpload)
			sbom.GET("/list", handleSBOMList)
		}
	}

	return r
}

func handleSBOMUpload(c *gin.Context) {
	c.JSON(http.StatusNotImplemented, gin.H{
		"message": "handleSBOMUpload - Not implemented yet",
	})
}

func handleSBOMList(c *gin.Context) {
	c.JSON(http.StatusNotImplemented, gin.H{
		"message": "handleSBOMList - Not implemented yet",
	})
}

func main() {
	r := setupRouter()
	r.Run(":8080")
}
