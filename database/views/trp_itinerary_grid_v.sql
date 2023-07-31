CREATE OR REPLACE FORCE VIEW trp_itinerary_grid_v AS
WITH r AS (
    SELECT /*+ MATERIALIZE */
        t.trip_id,
        t.day_,
        ROW_NUMBER() OVER (PARTITION BY trip_id ORDER BY day_) AS day#
    FROM (
        SELECT
            t.trip_id,
            TO_CHAR(TRUNC(t.start_at), 'YYYY-MM-DD') AS day_
        FROM trp_itinerary t
        GROUP BY
            t.trip_id,
            TO_CHAR(TRUNC(t.start_at), 'YYYY-MM-DD')
    ) t
)
SELECT
    t.trip_id       AS old_trip_id,
    t.stop_id       AS old_stop_id,
    t.trip_id,
    t.stop_id,
    t.stop_name,
    t.category_id,
    t.price,
    t.start_at,
    t.end_at,
    t.notes,
    r.day# || ') ' || r.day_ AS day#
FROM trp_itinerary t
JOIN r
    ON r.day_ = TO_CHAR(TRUNC(t.start_at), 'YYYY-MM-DD');
--
COMMENT ON TABLE trp_itinerary_grid_v IS '';

