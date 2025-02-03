CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create sbom_user role if not exists
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

-- Create database if not exists
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_database 
      WHERE datname = 'sbom_db') THEN
      CREATE DATABASE sbom_db;
   END IF;
END
$do$;

-- Connect to the sbom_db database
\c sbom_db;

-- Revoke all default privileges
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM PUBLIC;

-- Grant specific privileges to sbom_user
GRANT CONNECT ON DATABASE sbom_db TO sbom_user;
GRANT USAGE ON SCHEMA public TO sbom_user;

-- Table-specific privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO sbom_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO sbom_user;

-- Set default privileges for future tables/sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO sbom_user;
    
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT USAGE, SELECT ON SEQUENCES TO sbom_user;

-- Grant execute on uuid-ossp functions
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO sbom_user;

-- Set up auto-grant for new objects
ALTER DEFAULT PRIVILEGES FOR ROLE CURRENT_USER IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO sbom_user;
ALTER DEFAULT PRIVILEGES FOR ROLE CURRENT_USER IN SCHEMA public
    GRANT USAGE, SELECT ON SEQUENCES TO sbom_user;

