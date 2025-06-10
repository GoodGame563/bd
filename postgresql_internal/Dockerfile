FROM postgres:17-bookworm 


RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

COPY postgresql.conf /etc/postgresql/postgresql.conf

COPY initdb/ /docker-entrypoint-initdb.d/

RUN chmod a+r /etc/postgresql/postgresql.conf && \
    chmod a+rx /docker-entrypoint-initdb.d/*