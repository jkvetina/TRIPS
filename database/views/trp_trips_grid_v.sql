CREATE OR REPLACE FORCE VIEW trp_trips_grid_v AS
SELECT
    t.trip_id       AS old_trip_id,
    --
    t.trip_id,
    t.trip_name,
    t.start_at,
    t.end_at,
    t.created_by,
    t.created_at
    --
FROM trp_trips t
WHERE t.created_by = core.get_user_id();
--
COMMENT ON TABLE trp_trips_grid_v IS '';

