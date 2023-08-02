CREATE OR REPLACE FORCE VIEW trp_categories_grid_v AS
SELECT
    t.category_id       AS old_category_id,
    t.category_id,
    t.category_name,
    t.order#,
    t.color_fill,
    t.created_by,
    t.created_at
    --
FROM trp_categories t;
--
COMMENT ON TABLE trp_categories_grid_v IS '';

