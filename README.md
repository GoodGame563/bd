# Thesis Database Setup (Thesis)

This repository contains all configuration and initialization scripts for the database infrastructure of the thesis project: "Development of an analytics system for marketplace product grids using neural network technologies for automation and acceleration of assortment analysis".

## Purpose & Architecture

The `bd` directory provides setup for two PostgreSQL services (internal and user) and MongoDB, including schemas, functions, and extension scripts. It is designed for scalable, high-performance storage and retrieval of product, user, and analysis data.

### Main Components
- `postgresql_internal/`: Internal DB for keywords, products, partitioning
- `postgresql_user_service/`: User/session/task management
- `mongo.conf`: MongoDB configuration
- `initdb/`: SQL scripts for schema and function initialization
- `extensions/`: PostgreSQL extension installation scripts
- `.env-clear`: Example environment configuration for DB connection

## Directory Structure
```
├── postgresql_internal/
│   ├── postgresql.conf         # Main PostgreSQL config for internal service
│   └── initdb/
│       ├── 01-schema.sql       # Keywords & products tables with partitioning
│       └── ...                 # Additional SQL files
├── postgresql_user_service/
│   ├── postgresql.conf         # Main PostgreSQL config for user service
│   ├── initdb/
│   │   ├── 02-function.sql     # Stored procedures for user management
│   │   ├── 03-schema.sql       # Users, sessions, tasks tables
│   │   └── 04-base-data.sql    # Initial admin user data
│   └── extensions/
│       └── 01-install_extensions.sql  # PostgreSQL extension installation scripts
└── mongo.conf                  # Minimal MongoDB configuration
```

## Workflow
1. Launch DB containers via Docker
2. Initialize schemas and extensions using provided SQL scripts
3. System logs and monitoring via PostgreSQL extensions

## Features
- Partitioned tables for performance
- Hash indexes for fast lookups
- UUID v7-based identifiers
- Session and subscription management
- Admin user creation and security features
- MongoDB for flexible storage
- Performance tuning (shared_buffers, effective_cache_size, etc)
- Transactional updates and conflict resolution

## Configuration Notes
### PostgreSQL Settings
| Parameter                | Internal Service | User Service |
|--------------------------|------------------|--------------|
| `shared_buffers`         | 4GB             | 1GB          |
| `work_mem`               | 128MB           | 64MB         |
| `maintenance_work_mem`   | 2GB             | 512MB        |
| `max_parallel_workers`   | 4               | 4            |

### Required Extensions
```sql
-- Must be installed before running schemas
CREATE EXTENSION pg_partman;
CREATE EXTENSION pg_stat_statements;
CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION "pg_uuidv7";
CREATE EXTENSION pgcrypto;
```

## Usage
1. Build and run DB containers using Dockerfiles
2. Apply SQL scripts in `initdb/` for schema setup
3. Install extensions from `extensions/`

## Integration
- Used by API gateway, AI, and parser services
- All connection details configured in `.env` files of other repos

## Development Notes
- See thesis for DB schema diagrams and optimization strategies
- Refer to `README.alt1.md` and original README for more details

---
This is a highly detailed README for thesis documentation. Do not overwrite the original README if present.
