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
        rec.color_fill      := core.get_grid_data('COLOR_FILL');
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



    FUNCTION set_colors
    RETURN CLOB
    AS
        l_result        CLOB := '';
    BEGIN
        FOR c IN (
            SELECT DISTINCT
                t.category_id,
                t.color_fill
            FROM trp_categories t
            WHERE t.color_fill IS NOT NULL
        ) LOOP
            l_result := l_result || '.' || c.category_id || ' { fill: ' || c.color_fill || '; }' || CHR(10);
        END LOOP;
        --
        FOR c IN (
            SELECT DISTINCT
                t.color_fill
            FROM trp_itinerary_v t
            WHERE t.color_fill IS NOT NULL
        ) LOOP
            l_result := l_result || '.COLOR_' || LTRIM(c.color_fill, '#') || ' { fill: ' || c.color_fill || '; }' || CHR(10);
        END LOOP;
        --
        RETURN TO_CLOB('<style>') || l_result || TO_CLOB('</style>');
    END;

END;
/

