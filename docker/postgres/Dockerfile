FROM postgres:16-alpine

COPY docker/postgres/01-init.sql /docker-entrypoint-initdb.d/01-init.sql
COPY docker/postgres/02-schema.sql /docker-entrypoint-initdb.d/02-schema.sql
