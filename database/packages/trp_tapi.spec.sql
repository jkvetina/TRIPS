CREATE OR REPLACE PACKAGE trp_tapi as

    PROCEDURE save_trips (
        rec                 IN OUT NOCOPY   trp_trips%ROWTYPE,
        --
        in_action           CHAR                            := NULL,
        in_trip_id          trp_trips.trip_id%TYPE          := NULL
    );



    PROCEDURE save_trips_d (
        in_trip_id          trp_trips.trip_id%TYPE
    );



    PROCEDURE save_itinerary (
        rec                 IN OUT NOCOPY   trp_itinerary%ROWTYPE,
        --
        in_action           CHAR                                := NULL,
        in_trip_id          trp_itinerary.trip_id%TYPE          := NULL,
        in_stop_id          trp_itinerary.stop_id%TYPE          := NULL
    );



    PROCEDURE save_itinerary_d (
        in_trip_id          trp_itinerary.trip_id%TYPE,
        in_stop_id          trp_itinerary.stop_id%TYPE
    );



    PROCEDURE save_categories (
        rec                     IN OUT NOCOPY   trp_categories%ROWTYPE,
        --
        in_action               CHAR                                    := NULL,
        in_category_id          trp_categories.category_id%TYPE         := NULL
    );



    PROCEDURE save_categories_d (
        in_category_id          trp_categories.category_id%TYPE
    );

END;
/

