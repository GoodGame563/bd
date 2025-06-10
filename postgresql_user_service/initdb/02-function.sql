CREATE OR REPLACE FUNCTION create_user(
    p_id VARCHAR,
    p_email VARCHAR,
    p_name VARCHAR,
    p_is_admin BOOLEAN DEFAULT FALSE
) RETURNS VARCHAR AS $$
BEGIN
    INSERT INTO users (id, email, name, is_admin)
    VALUES (p_id, p_email, p_name, p_is_admin);
    
    RETURN p_id;
EXCEPTION WHEN unique_violation THEN
    RAISE EXCEPTION 'User with this ID or email already exists';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_user_session(
    p_user_id VARCHAR,
    p_browser VARCHAR,
    p_device VARCHAR,
    p_os VARCHAR
) RETURNS UUID AS $$
DECLARE
    new_session_id UUID;
BEGIN
    INSERT INTO user_session (user_id, browser, device, os)
    VALUES (p_user_id, p_browser, p_device, p_os)
    RETURNING id INTO new_session_id;
    
    RETURN new_session_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_task(
    p_name VARCHAR,
    p_user_id VARCHAR
) RETURNS UUID AS $$
DECLARE
    new_task_id UUID;
BEGIN
    INSERT INTO tasks (name, user_id)
    VALUES (p_name, p_user_id)
    RETURNING id INTO new_task_id;
    
    RETURN new_task_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION user_exists(
    p_id VARCHAR
) RETURNS BOOLEAN AS $$
DECLARE
    exists BOOLEAN;
BEGIN
    SELECT EXISTS(SELECT 1 FROM users WHERE id = p_id) INTO exists;
    RETURN exists;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION user_exists_email(
    p_email VARCHAR
) RETURNS BOOLEAN AS $$
DECLARE
    exists BOOLEAN;
BEGIN
    SELECT EXISTS(SELECT 1 FROM users WHERE email = p_email) INTO exists;
    RETURN exists;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_user(
    p_old_id VARCHAR,
    p_new_id VARCHAR,
    p_email VARCHAR DEFAULT NULL,
    p_name VARCHAR DEFAULT NULL,
    p_is_paid BOOLEAN DEFAULT NULL,
    p_is_admin BOOLEAN DEFAULT NULL
) RETURNS BOOLEAN AS $$
DECLARE
    user_count INTEGER;
BEGIN
    IF p_old_id != p_new_id THEN
        SELECT COUNT(*) INTO user_count FROM users WHERE id = p_new_id;
        IF user_count > 0 THEN
            RETURN FALSE;
        END IF;
    END IF;
    
    UPDATE users SET
        id = p_new_id,
        email = COALESCE(p_email, email),
        name = COALESCE(p_name, name),
        is_paid = COALESCE(p_is_paid, is_paid),
        is_admin = COALESCE(p_is_admin, is_admin)
    WHERE id = p_old_id;
    
    IF p_old_id != p_new_id THEN
        UPDATE user_session SET id_user = p_new_id WHERE id_user = p_old_id;
        UPDATE tasks SET user_id = p_new_id WHERE user_id = p_old_id;
    END IF;
    
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_user_subscription(
    p_user_id VARCHAR,
    p_created_at TIMESTAMPTZ,
    p_valid_to TIMESTAMPTZ
) RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO subscribe_users (user_id, created_at, valid_to)
    VALUES (p_user_id, p_created_at, p_valid_to);
    
    RETURN TRUE;
EXCEPTION WHEN foreign_key_violation THEN
    RAISE EXCEPTION 'User with ID % does not exist', p_user_id;
WHEN unique_violation THEN
    RAISE EXCEPTION 'Subscription for this user at this time already exists';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_user_session(
    p_session_id UUID
) RETURNS BOOLEAN AS $$
DECLARE
    exists BOOLEAN;
BEGIN
    SELECT EXISTS(
        SELECT 1 
        FROM user_session 
        WHERE id = p_session_id
    ) INTO exists;
    RETURN exists;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_session_activity(
    p_session_id UUID
) RETURNS BOOLEAN AS $$
BEGIN
    UPDATE user_session
    SET last_activity = NOW()
    WHERE id = p_session_id;
    
    RETURN FOUND;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_user_session_id(
    p_id VARCHAR
) RETURNS UUID AS $$
DECLARE
    new_session_id UUID := uuid_generate_v7();
BEGIN
    UPDATE user_session 
    SET id = new_session_id
    WHERE id = p_id;
    
    RETURN new_session_id;
END;
$$ LANGUAGE plpgsql;