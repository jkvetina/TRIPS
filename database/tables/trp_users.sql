CREATE TABLE trp_users (
    user_id                         VARCHAR2(128)   CONSTRAINT nn_trp_users_id NOT NULL,
    user_name                       VARCHAR2(64),
    user_mail                       VARCHAR2(128),
    is_active                       CHAR(1),
    updated_by                      VARCHAR2(128),
    updated_at                      DATE,
    --
    CONSTRAINT ch_trp_users_active
        CHECK (is_active = 'Y' OR is_active IS NULL),
    --
    CONSTRAINT pk_trp_users
        PRIMARY KEY (user_id)
);
--
COMMENT ON TABLE trp_users IS '';
--
COMMENT ON COLUMN trp_users.user_id     IS '';
COMMENT ON COLUMN trp_users.user_name   IS '';
COMMENT ON COLUMN trp_users.user_mail   IS '';
COMMENT ON COLUMN trp_users.is_active   IS '';

