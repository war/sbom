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

