CREATE OR REPLACE PACKAGE BODY trp_tapi as

    PROCEDURE save_trips (
        rec                 IN OUT NOCOPY   trp_trips%ROWTYPE,
        --
        in_action           CHAR                            := NULL,
        in_trip_id          trp_trips.trip_id%TYPE          := NULL
    )
    AS
        c_action            CONSTANT CHAR                   := gen_tapi.get_action(in_action);
    BEGIN
        -- delete record
        IF c_action = 'D' THEN
            trp_tapi.save_trips_d (
                in_trip_id          => NVL(in_trip_id, rec.trip_id)
            );
            --
            RETURN;  -- exit procedure
        END IF;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_trip_id != rec.trip_id THEN
            gen_tapi.rename_primary_key (
                in_column_name  => 'TRIP_ID',
                in_old_key      => in_trip_id,
                in_new_key      => rec.trip_id
            );
        END IF;

        -- overwrite some values
        rec.created_by      := NVL(rec.created_by, core.get_user_id());
        rec.created_at      := NVL(rec.created_at, SYSDATE);
        --
        IF rec.trip_id IS NULL THEN
            rec.trip_id := trp_trip_id.NEXTVAL;
        END IF;

        -- upsert record
        UPDATE trp_trips t
        SET ROW = rec
        WHERE t.trip_id             = rec.trip_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO trp_trips
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_trips_d (
        in_trip_id          trp_trips.trip_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        -- need to be sorted properly
        DELETE FROM trp_itinerary       WHERE trip_id = in_trip_id;
        DELETE FROM trp_trips           WHERE trip_id = in_trip_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_itinerary (
        rec                 IN OUT NOCOPY   trp_itinerary%ROWTYPE,
        --
        in_action           CHAR                                := NULL,
        in_trip_id          trp_itinerary.trip_id%TYPE          := NULL,
        in_stop_id          trp_itinerary.stop_id%TYPE          := NULL
    )
    AS
        c_action            CONSTANT CHAR                       := gen_tapi.get_action(in_action);
    BEGIN
        -- delete record
        IF c_action = 'D' THEN
            trp_tapi.save_itinerary_d (
                in_trip_id          => NVL(in_trip_id, rec.trip_id),
                in_stop_id          => NVL(in_stop_id, rec.stop_id)
            );
            --
            RETURN;  -- exit procedure
        END IF;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_trip_id != rec.trip_id THEN
            gen_tapi.rename_primary_key (
                in_column_name  => 'TRIP_ID',
                in_old_key      => in_trip_id,
                in_new_key      => rec.trip_id
            );
        END IF;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_stop_id != rec.stop_id THEN
            gen_tapi.rename_primary_key (
                in_column_name  => 'STOP_ID',
                in_old_key      => in_stop_id,
                in_new_key      => rec.stop_id
            );
        END IF;

        -- overwrite some values
        rec.created_by          := NVL(rec.created_by, core.get_user_id());
        rec.created_at          := NVL(rec.created_at, SYSDATE);
        --
        IF rec.stop_id IS NULL THEN
            rec.stop_id := trp_stop_id.NEXTVAL;
        END IF;

        -- upsert record
        UPDATE trp_itinerary t
        SET ROW = rec
        WHERE t.trip_id             = rec.trip_id
            AND t.stop_id           = rec.stop_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO trp_itinerary
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_itinerary_d (
        in_trip_id          trp_itinerary.trip_id%TYPE,
        in_stop_id          trp_itinerary.stop_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        DELETE FROM trp_itinerary t
        WHERE t.trip_id             = in_trip_id
            AND t.stop_id           = in_stop_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_categories (
        rec                     IN OUT NOCOPY   trp_categories%ROWTYPE,
        --
        in_action               CHAR                                    := NULL,
        in_category_id          trp_categories.category_id%TYPE         := NULL
    )
    AS
        c_action                CONSTANT CHAR                           := gen_tapi.get_action(in_action);
    BEGIN
        -- delete record
        IF c_action = 'D' THEN
            trp_tapi.save_categories_d (
                in_category_id          => NVL(in_category_id, rec.category_id)
            );
            --
            RETURN;  -- exit procedure
        END IF;

        -- are we renaming the primary key?
        IF c_action = 'U' AND in_category_id != rec.category_id THEN
            gen_tapi.rename_primary_key (
                in_column_name  => 'CATEGORY_ID',
                in_old_key      => in_category_id,
                in_new_key      => rec.category_id
            );
        END IF;

        -- overwrite some values
        rec.created_by          := NVL(rec.created_by, core.get_user_id());
        rec.created_at          := NVL(rec.created_at, SYSDATE);

        -- upsert record
        UPDATE trp_categories t
        SET ROW = rec
        WHERE t.category_id             = rec.category_id;
        --
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO trp_categories
            VALUES rec;
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE save_categories_d (
        in_category_id          trp_categories.category_id%TYPE
    )
    AS
        --PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        -- need to be sorted properly
        DELETE FROM trp_categories
        WHERE category_id = in_category_id;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

