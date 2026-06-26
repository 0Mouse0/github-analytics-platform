#!/bin/bash
# Postgres solo crea automaticamente la base definida en POSTGRES_DB (airflow).
# Este script crea las bases adicionales que necesita el proyecto:
#   - analytics    -> datos raw, staging y marts del pipeline de GitHub
#   - metabase_app -> metadata interna de Metabase (dashboards, usuarios, etc.)
set -e

create_database() {
  local database="$1"
  echo "Creando base de datos '${database}' (si no existe)..."
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    SELECT 'CREATE DATABASE ${database}'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '${database}')\gexec
EOSQL
}

create_database "analytics"
create_database "metabase_app"
