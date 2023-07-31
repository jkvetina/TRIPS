CREATE OR REPLACE FORCE VIEW trp_itinerary_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        t.trip_id,
        t.start_at      AS gantt_start_date,
        t.end_at + 2    AS gantt_end_date
    FROM trp_trips t
    WHERE t.trip_id = core.get_item('P100_TRIP_ID')
),
t AS (
    SELECT /*+ MATERIALIZE */
        t.trip_id,
        t.stop_id,
        t.stop_name,
        t.category_id,
        c.category_name,
        t.price,
        t.start_at,
        t.end_at,
        t.notes,
        x.gantt_start_date,
        x.gantt_end_date,
        c.order#
    FROM trp_itinerary t
    JOIN trp_categories c
        ON c.category_id = t.category_id
    JOIN x
        ON x.trip_id = t.trip_id
)
SELECT
    x.trip_id,
    NULL                AS row_id,
    c.order#            AS stop_id,
    c.category_name     AS stop_name,
    c.category_name,
    NULL                AS price,
    NULL                AS start_at,
    NULL                AS end_at,
    NULL                AS notes,
    x.gantt_start_date,
    x.gantt_end_date,
    NULL                AS css_class
FROM trp_categories c
CROSS JOIN x
UNION ALL
SELECT
    t.trip_id,
    t.order#            AS row_id,
    t.stop_id,
    t.stop_name,
    t.category_name,
    t.price,
    t.start_at,
    t.end_at,
    t.notes,
    t.gantt_start_date,
    t.gantt_end_date,
    t.category_id       AS css_class
FROM t
ORDER BY 1, 2 NULLS FIRST, 3;
--
COMMENT ON TABLE trp_itinerary_v IS '';

