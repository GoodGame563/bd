# Thesis Database Setup

This repository contains all necessary configuration and initialization scripts to launch the database infrastructure for a thesis project. It includes configurations for two PostgreSQL services and a MongoDB setup.

## 🗂️ Directory Structure

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

## 🧩 Key Components

### PostgreSQL Internal Service

**Keywords Management:**
- `keywords` table with unique text constraints
- Hash indexes for fast lookups (`keyword_text`, `keyword_id`)
- Partitioned `keyword_products` table with 33 partitions using HASH distribution

**Performance Tuning:**
- Recommended `shared_buffers`: 4GB
- Recommended `effective_cache_size`: 6GB
- `pg_partman_bgw` for automated partition maintenance
- `pg_stat_statements` for query performance monitoring

### PostgreSQL User Service

**User Management System:**
- UUID v7-based identifiers using `pg_uuidv7` extension
- Session tracking with device/browser metadata
- Subscription management with time-based validity

**Security Features:**
- Admin user creation with hashed credentials
- Foreign key constraints between user tables
- Transactional updates with conflict resolution

### MongoDB
- Minimalistic configuration for silent operation
- System logs redirected to `/dev/null`
- Extensible with additional storage engine configurations

## ⚙️ Configuration Notes

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

## 🚀 Getting Started

### Install Dependencies

```bash
sudo apt-get install postgresql-14
sudo apt-get install mongodb
```

### Initialize Databases

```bash
# For internal service
psql -f postgresql_internal/initdb/01-schema.sql

# For user service
psql -f postgresql_user_service/extensions/01-install_extensions.sql
psql -f postgresql_user_service/initdb/03-schema.sql
psql -f postgresql_user_service/initdb/02-function.sql
psql -f postgresql_user_service/initdb/04-base-data.sql
```

### Start Services

```bash
sudo systemctl start postgresql
sudo systemctl start mongod
```

## ⚠️ Important Considerations

- The `keyword_products` table uses HASH partitioning with modulus 33—ensure your data distribution aligns with this.
- All stored procedures include error handling for duplicate entries and foreign key violations.
- MongoDB configuration is intentionally minimal—modify as needed for production environments.
- The admin user in `04-base-data.sql` uses a SHA-256 hash format—replace with a proper authentication mechanism in production.
