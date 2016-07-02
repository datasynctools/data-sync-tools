SHOW search_path;

select table_schema, table_name from information_schema.tables where not table_schema='pg_catalog' and not table_schema='information_schema';

SET search_path TO public;

SHOW search_path;