CREATE OR REPLACE PACKAGE trp_tapi as

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

END;
/

