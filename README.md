# SBOM Management System Technical Architecture

## Usage
### 1. .env.example
Use the .env.example to create your own .env file.
### 2. Running the application
Use docker compose up to run everything
```
docker compose up
```
Or run and test individual services.
```
docker compose up api
```
The names of the services can be found in docker-compose.yaml

## Backend Architecture
### Data Storage
- **Primary Database:** PostgreSQL
- **Search Engine:** Elasticsearch

### Background Processing
- **Asynq**

### Core API Service
- **Language:** Go
- **Framework:** Gin

## Frontend Architecture
### Web Application
- **Framework:** Next.js
- **UI Components:** Tailwind CSS, Shadcn UI

## Local Development Infrastructure
### Container Management
- **Docker Compose**

### CI/CD
- **GitHub Actions**

## Development Tools
### Development Environment
- **Docker Compose**

### Code Quality
- **GolangCI-Lint**
- **ESLint + Prettier**
