CREATE TABLE IF NOT EXISTS users (
    id VARCHAR PRIMARY KEY,
    email VARCHAR NOT NULL UNIQUE,
    name VARCHAR NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE
);
CREATE INDEX IF NOT EXISTS users_id_idx ON users (id); 
CREATE INDEX IF NOT EXISTS users_email_idx ON users (email); 

CREATE TABLE IF NOT EXISTS user_session(
    id uuid DEFAULT uuid_generate_v7(),
    user_id VARCHAR NOT NULL,
    browser VARCHAR NOT NULL, 
    device VARCHAR NOT NULL, 
    os VARCHAR NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    last_activity TIMESTAMPTZ DEFAULT NOW() NOT NULL
);
CREATE INDEX IF NOT EXISTS user_session_id_user_idx ON user_session (user_id); 
CREATE INDEX IF NOT EXISTS user_session_id_idx ON user_session (id); 

DROP TABLE IF EXISTS tasks CASCADE;
CREATE TABLE tasks (
    id uuid DEFAULT uuid_generate_v7(),
    name VARCHAR NOT NULL,
    user_id VARCHAR REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    PRIMARY KEY (id, created_at)
);
CREATE INDEX tasks_user_id_idx ON tasks (user_id);

CREATE TABLE subscribe_users(
    user_id VARCHAR NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    valid_to TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (user_id)
);