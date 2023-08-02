CREATE TABLE trp_itinerary (
    trip_id                         NUMBER(10,0)    NOT NULL,
    stop_id                         NUMBER(4,0)     NOT NULL,
    stop_name                       VARCHAR2(128)   NOT NULL,
    category_id                     VARCHAR2(32)    NOT NULL,
    price                           NUMBER(10,0),
    start_at                        DATE,
    end_at                          DATE,
    notes                           VARCHAR2(4000),
    color_fill                      VARCHAR2(8),
    created_by                      VARCHAR2(128),
    created_at                      DATE,
    is_reserved                     CHAR(1),
    is_paid                         CHAR(1),
    is_pending                      CHAR(1),
    --
    CONSTRAINT pk_trp_itinerary
        PRIMARY KEY (trip_id, stop_id),
    --
    CONSTRAINT fk_trp_itinerary_reserved
        CHECK (is_reserved = 'Y' OR is_reserved IS NULL),
    --
    CONSTRAINT fk_trp_itinerary_paid
        CHECK (is_paid = 'Y' OR is_paid IS NULL),
    --
    CONSTRAINT fk_trp_itinerary_pending
        CHECK (is_pending = 'Y' OR is_pending IS NULL),
    --
    CONSTRAINT fk_trp_itinerary_trip
        FOREIGN KEY (trip_id)
        REFERENCES trp_trips (trip_id),
    --
    CONSTRAINT fk_trp_itinerary_category
        FOREIGN KEY (category_id)
        REFERENCES trp_categories (category_id)
);
--
COMMENT ON TABLE trp_itinerary IS '';
--
COMMENT ON COLUMN trp_itinerary.trip_id         IS '';
COMMENT ON COLUMN trp_itinerary.stop_id         IS '';
COMMENT ON COLUMN trp_itinerary.stop_name       IS '';
COMMENT ON COLUMN trp_itinerary.category_id     IS '';
COMMENT ON COLUMN trp_itinerary.price           IS '';
COMMENT ON COLUMN trp_itinerary.start_at        IS '';
COMMENT ON COLUMN trp_itinerary.end_at          IS '';
COMMENT ON COLUMN trp_itinerary.notes           IS '';
COMMENT ON COLUMN trp_itinerary.color_fill      IS '';
COMMENT ON COLUMN trp_itinerary.is_reserved     IS '';
COMMENT ON COLUMN trp_itinerary.is_paid         IS '';
COMMENT ON COLUMN trp_itinerary.is_pending      IS '';

