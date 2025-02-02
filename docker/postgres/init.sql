CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create sbom_user role
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE rolname = 'sbom_user') THEN
      CREATE ROLE sbom_user LOGIN PASSWORD 'sbom_password';
   END IF;
END
$do$;

-- Grant privileges
ALTER ROLE sbom_user WITH SUPERUSER;

-- Create database if not exists
SELECT 'CREATE DATABASE sbom_db'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'sbom_db')

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE sbom_db TO sbom_user;
