CREATE OR REPLACE FORCE VIEW trp_itinerary_grid_v AS
WITH x AS (
    SELECT /*+ MATERIALIZE */
        t.trip_id,
        core.get_item('P100_DAY') AS day_
    FROM trp_trips t
    WHERE t.trip_id = core.get_number_item('P100_TRIP_ID')
),
r AS (
    SELECT /*+ MATERIALIZE */
        t.trip_id,
        t.day_,
        ROW_NUMBER() OVER (PARTITION BY trip_id ORDER BY day_) AS day#
    FROM (
        SELECT
            t.trip_id,
            TO_CHAR(TRUNC(t.start_at), 'YYYY-MM-DD') AS day_
        FROM trp_itinerary t
        JOIN x
            ON x.trip_id = t.trip_id
        GROUP BY
            t.trip_id,
            TO_CHAR(TRUNC(t.start_at), 'YYYY-MM-DD')
    ) t
)
SELECT
    t.trip_id       AS old_trip_id,
    t.stop_id       AS old_stop_id,
    --
    t.trip_id,
    t.stop_id,
    t.stop_name,
    t.category_id,
    t.price,
    t.link_reservation,
    t.link_event,
    t.is_reserved,
    t.is_paid,
    t.is_pending,
    t.start_at,
    t.end_at,
    t.notes,
    t.color_fill,
    --
    r.day#,
    r.day_
FROM trp_itinerary t
JOIN x
    ON x.trip_id = t.trip_id
JOIN r
    ON r.day_ = TO_CHAR(TRUNC(t.start_at), 'YYYY-MM-DD')
WHERE 1 = 1
    AND (r.day_ = x.day_ OR x.day_ IS NULL);
--
COMMENT ON TABLE trp_itinerary_grid_v IS '';

