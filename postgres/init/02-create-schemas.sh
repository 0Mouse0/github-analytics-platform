#!/bin/bash
# Crea los tres schemas que usaremos dentro de la base "analytics":
#   raw      -> datos crudos extraidos de la API de GitHub (append-only, con timestamp)
#   staging  -> tablas de dbt con limpieza y tipado basico
#   marts    -> tablas finales listas para los dashboards
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "analytics" <<-EOSQL
  CREATE SCHEMA IF NOT EXISTS raw;
  CREATE SCHEMA IF NOT EXISTS staging;
  CREATE SCHEMA IF NOT EXISTS marts;
EOSQL
