CREATE OR REPLACE FORCE VIEW trp_itinerary_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        core.get_number_item('P100_TRIP_ID')            AS trip_id,
        core.get_date_item('P100_DAY', 'YYYY-MM-DD')    AS day_
    FROM DUAL
),
d AS (
    SELECT /*+ MATERIALIZE */
        t.trip_id,
        CASE WHEN x.day_ IS NOT NULL THEN x.day_ ELSE t.start_at END    AS gantt_start_date,
        CASE WHEN x.day_ IS NOT NULL THEN x.day_ ELSE t.end_at END + 1  AS gantt_end_date
    FROM trp_trips t
    JOIN x
        ON x.trip_id = t.trip_id
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
        d.gantt_start_date,
        d.gantt_end_date,
        c.order#,
        t.color_fill
    FROM trp_itinerary t
    JOIN trp_categories c
        ON c.category_id = t.category_id
    JOIN d
        ON d.trip_id = t.trip_id
)
SELECT
    d.trip_id,
    NULL                AS row_id,
    c.order#            AS stop_id,
    c.category_name     AS stop_name,
    c.category_name,
    NULL                AS price,
    NULL                AS start_at,
    NULL                AS end_at,
    NULL                AS baseline_start_at,
    NULL                AS baseline_end_at,
    NULL                AS notes,
    d.gantt_start_date,
    d.gantt_end_date,
    NULL                AS css_class,
    NULL                AS color_fill
FROM trp_categories c
CROSS JOIN d
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
    CASE WHEN t.category_id = 'AIRPLANE' THEN (t.start_at - 2/24) END   AS baseline_start_at,
    CASE WHEN t.category_id = 'AIRPLANE' THEN (t.end_at + 20/1440) END  AS baseline_end_at,
    t.notes,
    t.gantt_start_date,
    t.gantt_end_date,
    'DEFAULT ' || t.category_id || NULLIF(' COLOR_' || LTRIM(t.color_fill, '#'), ' COLOR_') AS css_class,
    t.color_fill
FROM t
ORDER BY 1, 2 NULLS FIRST, 3;
--
COMMENT ON TABLE trp_itinerary_v IS '';

