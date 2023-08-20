CREATE OR REPLACE FORCE VIEW trp_lov_categories_v AS
SELECT
    t.category_id,
    t.category_name,
    --
    ROW_NUMBER() OVER (ORDER BY t.order#, t.category_id) AS order#
    --
FROM trp_categories t
WHERE t.is_lov = 'Y';
--
COMMENT ON TABLE trp_lov_categories_v IS '';

