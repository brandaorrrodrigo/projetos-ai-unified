-- =========================================
-- SCRIPT DE INICIALIZAÇÃO - DATABASES
-- Criado em: 07/02/2026
-- =========================================
-- Este script cria automaticamente os 8 databases
-- para os 9 projetos AI quando o PostgreSQL inicia

-- Databases dos Projetos
CREATE DATABASE nutrifitcoach;
CREATE DATABASE doutora_ia;
CREATE DATABASE juris_ia;
CREATE DATABASE ekids;
CREATE DATABASE enem_ia;
CREATE DATABASE petcontrol;
CREATE DATABASE medcontrol;
CREATE DATABASE doutora_oab;

-- Conectar a cada database e criar extensões necessárias

\c nutrifitcoach;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

\c doutora_ia;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

\c juris_ia;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS vector;

\c ekids;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

\c enem_ia;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

\c petcontrol;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

\c medcontrol;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

\c doutora_oab;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- =========================================
-- Criação de Usuários Específicos (Opcional)
-- Descomente se desejar usuarios com less privileges
-- =========================================

-- CREATE USER nfc_user WITH PASSWORD 'nfc_pass';
-- GRANT ALL PRIVILEGES ON DATABASE nutrifitcoach TO nfc_user;
-- CREATE USER doutora_user WITH PASSWORD 'doutora_pass';
-- GRANT ALL PRIVILEGES ON DATABASE doutora_ia TO doutora_user;

-- =========================================
-- FIM DO SCRIPT
-- =========================================
