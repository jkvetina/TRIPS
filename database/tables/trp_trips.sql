CREATE TABLE trp_trips (
    trip_id                         NUMBER(10,0)    NOT NULL,
    trip_name                       VARCHAR2(128)   NOT NULL,
    start_at                        DATE            NOT NULL,
    end_at                          DATE            NOT NULL,
    created_by                      VARCHAR2(128),
    created_at                      DATE,
    --
    CONSTRAINT pk_trp_trips
        PRIMARY KEY (trip_id)
);
--
COMMENT ON TABLE trp_trips IS '';
--
COMMENT ON COLUMN trp_trips.trip_id     IS '';
COMMENT ON COLUMN trp_trips.trip_name   IS '';
COMMENT ON COLUMN trp_trips.start_at    IS '';
COMMENT ON COLUMN trp_trips.end_at      IS '';

