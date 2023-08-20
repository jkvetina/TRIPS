CREATE TABLE trp_categories (
    category_id                     VARCHAR2(32)    NOT NULL,
    category_name                   VARCHAR2(128)   NOT NULL,
    order#                          NUMBER(4,0),
    color_fill                      VARCHAR2(8),
    created_by                      VARCHAR2(128),
    created_at                      DATE,
    is_lov                          CHAR(1),
    --
    CONSTRAINT pk_trp_categories
        PRIMARY KEY (category_id),
    --
    CONSTRAINT ch_trp_categories_active
        CHECK (is_lov = 'Y' OR is_lov IS NULL)
);
--
COMMENT ON TABLE trp_categories IS '';
--
COMMENT ON COLUMN trp_categories.category_id        IS '';
COMMENT ON COLUMN trp_categories.category_name      IS '';
COMMENT ON COLUMN trp_categories.order#             IS '';
COMMENT ON COLUMN trp_categories.color_fill         IS '';
COMMENT ON COLUMN trp_categories.is_lov             IS '';

