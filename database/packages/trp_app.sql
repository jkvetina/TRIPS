CREATE OR REPLACE PACKAGE BODY trp_app as

    PROCEDURE save_itinerary
    AS
        rec                 trp_itinerary%ROWTYPE;
        in_action           CONSTANT CHAR := core.get_grid_action();
    BEGIN
        -- change record in table
        rec.trip_id         := core.get_grid_data('TRIP_ID');
        rec.stop_id         := core.get_grid_data('STOP_ID');
        rec.stop_name       := core.get_grid_data('STOP_NAME');
        rec.category_id     := core.get_grid_data('CATEGORY_ID');
        rec.price           := core.get_grid_data('PRICE');
        rec.start_at        := core.get_date(core.get_grid_data('START_AT'));
        rec.end_at          := core.get_date(core.get_grid_data('END_AT'));
        rec.notes           := core.get_grid_data('NOTES');
        --
        trp_tapi.save_itinerary (rec,
            in_action           => in_action,
            in_trip_id          => NVL(core.get_grid_data('OLD_TRIP_ID'), rec.trip_id),
            in_stop_id          => NVL(core.get_grid_data('OLD_STOP_ID'), rec.stop_id)
        );
        --
        IF in_action = 'D' THEN
            RETURN;     -- exit this procedure
        END IF;

        -- update primary key back to APEX grid for proper row refresh
        core.set_grid_data('OLD_TRIP_ID',       rec.trip_id);
        core.set_grid_data('OLD_STOP_ID',       rec.stop_id);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

