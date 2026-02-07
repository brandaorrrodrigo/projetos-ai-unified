# 🚀 Infraestrutura Unificada - 9 Projetos AI

> Gerenciamento centralizado de múltiplos projetos AI/Apps em um único docker-compose

**Status:** ✅ Operacional
**Versão:** 1.0
**Data:** 07/02/2026

---

## 📊 Projetos Incluídos

| # | Projeto | Tipo | Ports | Status |
|---|---------|------|-------|--------|
| 1 | **NutriFitCoach** | Nutrição/Fitness | 3003, 8001 | ✅ |
| 2 | **Doutora IA** | Consultoria Médica | 3000, 8080 | ✅ |
| 3 | **Juris IA** | Consultoria Jurídica | 8003 | ✅ |
| 4 | **E-Kids Pro** | Educação Infantil | 3100, 3101 | ✅ |
| 5 | **ENEM-IA** | Prep. ENEM | 3002, 8002 | ✅ |
| 6 | **PetControl** | Gestão Veterinária | 3004 | ✅ |
| 7 | **MediControl** | Gestão Medicamentos | 3005 | ✅ |
| 8 | **Doutora IA OAB** | Exame OAB | 3006 | ✅ |

---

## 🏗️ Infraestrutura Compartilhada

### Serviços Base

| Serviço | Imagem | Port | Descrição |
|---------|--------|------|-----------|
| **PostgreSQL** | postgres:16 | 5432 | Database central (8 databases) |
| **Redis** | redis:7 | 6379 | Cache compartilhado |
| **Ollama** | ollama:latest | 11434 | IA local (LLMs) |
| **Qdrant** | qdrant:latest | 6333-6334 | Vector database |

### Ferramentas Admin

| Ferramenta | Acesso | Descrição |
|-----------|--------|-----------|
| **PgAdmin** | http://localhost:5050 | Gerenciador PostgreSQL |
| **Redis Commander** | http://localhost:8081 | Gerenciador Redis |

---

## 🚀 Como Usar

### Subir TUDO (Todos os 9 projetos + infraestrutura)

```bash
cd /d/projetos-ai-unified

# Subir com logs
docker-compose up

# Ou em background
docker-compose up -d
```

### Subir Apenas Infraestrutura

```bash
docker-compose up -d postgres redis ollama qdrant
```

### Subir Um Projeto Específico

```bash
# NutriFitCoach
docker-compose up -d nutrifitcoach-backend nutrifitcoach-frontend

# Doutora IA
docker-compose up -d doutora-backend doutora-frontend

# E-Kids Pro
docker-compose up -d ekids-main ekids-chat
```

### Ver Logs

```bash
# Todos os serviços
docker-compose logs -f

# Um serviço específico
docker-compose logs -f doutora-backend

# Últimas 50 linhas de um serviço
docker-compose logs --tail 50 ekids-main
```

### Status dos Serviços

```bash
docker-compose ps

# Com formatação melhor
docker-compose ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

### Parar Tudo

```bash
docker-compose stop
```

### Parar e Remover Containers

```bash
docker-compose down
```

### Remover TUDO (⚠️ inclui dados!)

```bash
docker-compose down -v
```

---

## 🔑 Configuração de Variáveis

### Arquivo `.env.global`

Este arquivo contém as variáveis compartilhadas:

```bash
# PostgreSQL
POSTGRES_USER=postgres
POSTGRES_PASSWORD=seu_senha_aqui

# Redis
REDIS_PASSWORD=seu_password_aqui

# Ollama
OLLAMA_MODEL=llama2

# Timezone
TZ=America/Sao_Paulo
```

### Para Sobrescrever Variáveis

```bash
# Via linha de comando
docker-compose -e POSTGRES_PASSWORD=nova_senha up -d

# Via arquivo .env
cp .env.global .env
# Edite o arquivo .env conforme necessário
docker-compose up -d
```

---

## 📚 Estrutura de Diretórios

```
/d/projetos-ai-unified/
├── docker-compose.yml           ← Orquestração principal
├── .env.global                  ← Variáveis compartilhadas
├── README.md                    ← Este arquivo
│
├── infra/                       ← Infraestrutura
│   ├── postgres/
│   │   └── init.sql            ← Criação dos 8 databases
│   ├── redis/
│   ├── ollama/
│   └── backups/
│
├── nutrifitcoach/              ← Projeto 1 (links simbólicos)
├── doutora-ia/                 ← Projeto 2
├── juris-ia/                   ← Projeto 3
├── ekids/                      ← Projeto 4
├── enem-ia/                    ← Projeto 5
├── petcontrol/                 ← Projeto 6
├── medcontrol/                 ← Projeto 7
└── doutora-ia-oab/             ← Projeto 8
```

---

## 🔗 Conectar Projetos Locais

Para que o docker-compose encontre os projetos, crie links simbólicos:

```bash
cd /d/projetos-ai-unified

# Criar links para os projetos
ln -s /d/NUTRIFITCOACH_MASTER nutrifitcoach
ln -s /d/doutora-ia doutora-ia
ln -s /d/JURIS_IA_CORE_V1 juris-ia
ln -s /d/E-Kids-PRO ekids
ln -s /d/enem-ia enem-ia
ln -s /d/petcontrol-ia/petcontrol-pro petcontrol
ln -s /d/MEDCONTROL medcontrol
ln -s /d/doutora-ia-oab-frontend doutora-ia-oab

# Verificar
ls -la
```

---

## 🔧 Gerenciamento de Banco de Dados

### Acessar PostgreSQL via PgAdmin

1. Acesse: http://localhost:5050
2. Email: `admin@projetos-ai.local`
3. Password: `admin`
4. Adicione um novo servidor:
   - Host: `postgres`
   - Port: `5432`
   - Username: `postgres`
   - Password: `${POSTGRES_PASSWORD}`

### Acessar Redis via Redis Commander

1. Acesse: http://localhost:8081
2. Ver todas as chaves: `KEYS *`
3. Executar comandos: CLI disponível

### Fazer Backup do PostgreSQL

```bash
docker-compose exec postgres pg_dump -U postgres nutrifitcoach > backup_nutrifitcoach.sql
```

### Restaurar do Backup

```bash
docker-compose exec -T postgres psql -U postgres nutrifitcoach < backup_nutrifitcoach.sql
```

---

## 🌐 Acessar os Projetos

### Frontends (Next.js/React)

- NutriFitCoach: http://localhost:3003
- Doutora IA: http://localhost:3000
- ENEM-IA: http://localhost:3002
- E-Kids Pro: http://localhost:3100
- PetControl: http://localhost:3004
- MediControl: http://localhost:3005
- Doutora IA OAB: http://localhost:3006

### APIs (Backend)

- NutriFitCoach API: http://localhost:8001
- Doutora IA API: http://localhost:8080
- Juris IA API: http://localhost:8003
- ENEM-IA API: http://localhost:8002

### Serviços

- Ollama: http://localhost:11434
- Qdrant: http://localhost:6333
- Redis Commander: http://localhost:8081
- PgAdmin: http://localhost:5050

---

## 📋 Health Checks

O docker-compose verifica automaticamente a saúde dos serviços:

```bash
# Ver status de saúde
docker-compose ps

# Ou de forma mais detalhada
docker inspect --format='{{.State.Health.Status}}' unified-postgres
```

### Endpoints de Health Check

```bash
# PostgreSQL
curl postgres:5432  # Responde com porta aberta

# Redis
redis-cli ping

# Ollama
curl http://localhost:11434/api/status

# Qdrant
curl http://localhost:6333/health
```

---

## 🔐 Segurança

### Senhas Padrão (Mude em Produção!)

```
PostgreSQL: postgres / postgres
Redis: (vazio por padrão, configure em .env.global)
PgAdmin: admin@projetos-ai.local / admin
```

### Como Mudar Senhas

1. Edite `.env.global`:
   ```bash
   POSTGRES_PASSWORD=nova_senha_super_segura
   REDIS_PASSWORD=outra_senha_segura
   ```

2. Remova containers e volumes:
   ```bash
   docker-compose down -v
   ```

3. Suba novamente:
   ```bash
   docker-compose up -d
   ```

### Firewall / Acesso Externo

Para permitir acesso externo (⚠️ Cuidado com segurança!):

```yaml
ports:
  - "0.0.0.0:5432:5432"  # PostgreSQL para todo mundo
```

Recomendação: Use VPN ou proxy reverso em produção.

---

## 🆘 Troubleshooting

### Container não sobe

```bash
# Ver logs detalhados
docker-compose logs --tail 100 nome-do-container

# Reconstruir imagem
docker-compose build --no-cache nome-do-container

# Limpar e recomeçar
docker-compose down -v
docker-compose up -d
```

### Problema de Porta Ocupada

```bash
# Encontrar processo usando a porta
lsof -i :5432  # ou qual porta

# Ou se em Windows
Get-NetTCPConnection -LocalPort 5432
```

### Database não é criada

```bash
# Verificar se init.sql foi executado
docker-compose logs postgres | grep "init.sql"

# Reconstruir do zero
docker-compose exec postgres psql -U postgres -f /docker-entrypoint-initdb.d/01-init.sql
```

### Conexão recusada entre containers

```bash
# Testar conectividade
docker-compose exec doutora-backend ping postgres
docker-compose exec doutora-backend redis-cli -h redis ping
```

---

## 📈 Performance Tips

### 1. Limpar Dados Antigos

```bash
# Limpar logs docker
docker system prune

# Limpar volumes não utilizados
docker volume prune
```

### 2. Otimizar PostgreSQL

```bash
# Aumentar max_connections em produção
docker-compose exec postgres sed -i "s/max_connections = 100/max_connections = 1000/" /var/lib/postgresql/data/postgresql.conf
```

### 3. Usar GPU para Ollama

Descomente a seção `deploy.resources.reservations.devices` no docker-compose.yml

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: 1
          capabilities: [gpu]
```

---

## 📞 Suporte

### Verificar Versões

```bash
docker-compose --version
docker --version
```

### Logs do Sistema

```bash
# Todos os serviços
docker-compose logs > logs_completos.txt

# Um serviço em tempo real
docker-compose logs -f --tail 50 doutora-backend
```

---

## 📝 Checklist de Deployment

- [ ] Copiar `.env.global` e ajustar senhas
- [ ] Criar links simbólicos para os projetos
- [ ] Subir infraestrutura: `docker-compose up -d postgres redis ollama qdrant`
- [ ] Verificar saúde: `docker-compose ps`
- [ ] Testar PgAdmin: http://localhost:5050
- [ ] Testar Redis Commander: http://localhost:8081
- [ ] Subir projetos um por um
- [ ] Testar endpoints de health
- [ ] Verificar logs para erros
- [ ] Documentar IPs/URLs em produção

---

## 🎉 Status

✅ **Infraestrutura Unificada Pronta**
✅ **8 Projetos Configurados**
✅ **PostgreSQL Centralizado**
✅ **Redis Compartilhado**
✅ **Ollama Integrado**
✅ **Ferramentas Admin**

---

**Última Atualização:** 07/02/2026
**Versão:** 1.0
**Mantido por:** Claude Code

Para atualizações, veja: `/d/projetos-ai-unified/docker-compose.yml`
