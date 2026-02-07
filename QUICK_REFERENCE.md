# ⚡ QUICK REFERENCE - Comandos Essenciais

## 🚀 START / STOP

```bash
# Subir TUDO
docker-compose up -d

# Subir apenas infraestrutura
docker-compose up -d postgres redis ollama qdrant

# Subir um projeto específico
docker-compose up -d doutora-backend doutora-frontend

# Parar tudo
docker-compose stop

# Parar um serviço
docker-compose stop doutora-backend

# Remover containers (dados persistem)
docker-compose down

# Remover TUDO incluindo dados ⚠️
docker-compose down -v
```

---

## 📊 STATUS & LOGS

```bash
# Ver status de todos
docker-compose ps

# Ver status formatado
docker-compose ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Logs em tempo real (todos)
docker-compose logs -f

# Logs de um serviço
docker-compose logs -f doutora-backend

# Últimas 50 linhas
docker-compose logs --tail 50 ekids-main

# Ver health status
docker-compose exec postgres pg_isready -U postgres
docker-compose exec redis redis-cli ping
```

---

## 🔧 BANCO DE DADOS

### PostgreSQL

```bash
# Conectar ao PostgreSQL
docker-compose exec postgres psql -U postgres

# Listar databases
docker-compose exec postgres psql -U postgres -l

# Acessar uma database
docker-compose exec postgres psql -U postgres nutrifitcoach

# Fazer backup
docker-compose exec postgres pg_dump -U postgres nutrifitcoach > backup.sql

# Restaurar
docker-compose exec -T postgres psql -U postgres nutrifitcoach < backup.sql

# Executar SQL direto
docker-compose exec postgres psql -U postgres -c "SELECT * FROM users LIMIT 1;"

# Resetar database
docker-compose exec postgres psql -U postgres -c "DROP DATABASE nutrifitcoach; CREATE DATABASE nutrifitcoach;"
```

### Redis

```bash
# Conectar ao Redis
docker-compose exec redis redis-cli

# Com autenticação
docker-compose exec redis redis-cli -a <REDIS_PASSWORD>

# Ping
docker-compose exec redis redis-cli ping

# Ver todas as chaves
docker-compose exec redis redis-cli KEYS "*"

# Obter valor de chave
docker-compose exec redis redis-cli GET "chave"

# Limpar tudo
docker-compose exec redis redis-cli FLUSHALL

# Informações do servidor
docker-compose exec redis redis-cli INFO
```

---

## 🐳 DOCKER

```bash
# Construir imagem específica
docker-compose build doutora-backend

# Reconstruir sem cache
docker-compose build --no-cache doutora-backend

# Ver imagens
docker images | grep unified

# Ver volumes
docker volume ls | grep unified

# Limpar cache Docker
docker system prune -a --volumes

# Ver espaço usado
docker system df
```

---

## 🌐 ACESSAR APLICAÇÕES

| Serviço | URL |
|---------|-----|
| Doutora IA | http://localhost:3000 |
| NutriFitCoach | http://localhost:3003 |
| ENEM-IA | http://localhost:3002 |
| E-Kids Pro | http://localhost:3100 |
| E-Kids Chat | http://localhost:3101 |
| PetControl | http://localhost:3004 |
| MediControl | http://localhost:3005 |
| Doutora IA OAB | http://localhost:3006 |
| **PgAdmin** | http://localhost:5050 |
| **Redis Commander** | http://localhost:8081 |
| **Ollama** | http://localhost:11434 |
| **Qdrant** | http://localhost:6333 |

---

## 🔐 CREDENCIAIS PADRÃO

```
PostgreSQL:
  User: postgres
  Password: ${POSTGRES_PASSWORD} (editar em .env.global)

Redis:
  Password: ${REDIS_PASSWORD} (editar em .env.global)

PgAdmin:
  Email: admin@projetos-ai.local
  Password: admin

  Servidor PostgreSQL:
    Host: postgres
    Port: 5432
    User: postgres
    Password: ${POSTGRES_PASSWORD}
```

---

## 🚨 TROUBLESHOOTING RÁPIDO

```bash
# Container não sobe?
docker-compose logs --tail 100 nome-do-container

# Erro de conexão?
docker-compose exec nome-do-container ping postgres
docker-compose exec nome-do-container redis-cli -h redis ping

# Porta em uso?
# Windows:
Get-NetTCPConnection -LocalPort 5432 | Select-Object -Property State,OwningProcess

# Linux/Mac:
lsof -i :5432

# Limpar e recomeçar (radical):
docker-compose down -v
rm -rf ~/.docker  # ⚠️ Só se necessário
docker-compose up -d
```

---

## 💾 BACKUP & RESTAURAÇÃO

```bash
# Backup de um database
docker-compose exec postgres pg_dump -U postgres nutrifitcoach > backup_nutrifitcoach_$(date +%Y%m%d_%H%M%S).sql

# Backup de TUDO
docker-compose exec postgres pg_dumpall -U postgres > backup_completo_$(date +%Y%m%d_%H%M%S).sql

# Restaurar um database
docker-compose exec -T postgres psql -U postgres nutrifitcoach < backup_nutrifitcoach_20260207_160000.sql

# Restaurar TUDO
docker-compose exec -T postgres psql -U postgres < backup_completo_20260207_160000.sql
```

---

## 🔄 REINICIAR SERVIÇOS

```bash
# Reiniciar um serviço
docker-compose restart doutora-backend

# Reiniciar vários
docker-compose restart doutora-backend doutora-frontend

# Parar e iniciar (mesmo que restart)
docker-compose stop doutora-backend && docker-compose start doutora-backend

# Forçar reinicialização completa
docker-compose down && docker-compose up -d
```

---

## 📈 MONITORAMENTO

```bash
# Ver uso de recursos
docker stats

# Ver uso de memória de um container
docker stats doutora-backend

# Ver eventos em tempo real
docker events

# Health check de um serviço
docker-compose exec postgres pg_isready -v -U postgres
```

---

## 🛠️ MAINTENANCE

```bash
# Limpar logs antigos
docker exec unified-postgres find /var/log/postgresql -mtime +7 -delete

# Otimizar PostgreSQL
docker-compose exec postgres vacuum analyze;

# Ver versões
docker-compose --version
docker --version
```

---

## 📝 CONFIGURAÇÃO

```bash
# Editar .env.global
nano /d/projetos-ai-unified/.env.global

# Validar docker-compose
docker-compose config

# Ver variáveis de um serviço
docker-compose config | grep -A 10 "doutora-backend:"
```

---

## 🚀 DEPLOY STEPS

1. **Editar senhas:**
   ```bash
   nano /d/projetos-ai-unified/.env.global
   ```

2. **Subir infraestrutura:**
   ```bash
   cd /d/projetos-ai-unified
   docker-compose up -d postgres redis ollama qdrant
   ```

3. **Aguardar health:**
   ```bash
   docker-compose ps  # Aguarde até "healthy"
   ```

4. **Subir projetos:**
   ```bash
   docker-compose up -d
   ```

5. **Verificar status:**
   ```bash
   docker-compose ps --format "table {{.Names}}\t{{.Status}}"
   ```

---

## 💡 DICAS

- Sempre edite `.env.global` ANTES de fazer deploy em produção
- Use `docker-compose logs -f` para debug em tempo real
- Faça backups regularmente dos databases importantes
- Monitore o uso de disco com `docker system df`
- Limpe imagens/volumes não usados periodicamente
- Use `docker-compose ps` para verificar status geral

---

**Última atualização:** 07/02/2026
**Próxima documentação:** `/d/projetos-ai-unified/README.md`
