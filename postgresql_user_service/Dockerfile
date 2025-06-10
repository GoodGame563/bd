FROM postgres:17

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    make \
    gcc \
    git \
    curl \
    gnupg \
    postgresql-server-dev-17 \
    postgresql-contrib && \
    cd /tmp && \
    git clone https://github.com/pgpartman/pg_partman.git && \
    cd pg_partman && \
    make install && \
    cd /tmp && \
    git clone https://github.com/fboulnois/pg_uuidv7.git && \
    cd pg_uuidv7 && \
    make install && \
    apt-get remove -y make gcc git postgresql-server-dev-17 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /tmp/pg_partman /tmp/pg_uuidv7 /var/lib/apt/lists/*

COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY initdb/ /docker-entrypoint-initdb.d/
COPY extensions/ /docker-entrypoint-initdb.d/

RUN chmod a+r /etc/postgresql/postgresql.conf && \
    chmod a+rx /docker-entrypoint-initdb.d/*