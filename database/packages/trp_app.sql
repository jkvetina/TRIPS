CREATE OR REPLACE PACKAGE BODY trp_app as

    PROCEDURE save_trips
    AS
        rec                 trp_trips%ROWTYPE;
        in_action           CONSTANT CHAR := core.get_grid_action();
    BEGIN
        -- change record in table
        rec.trip_id         := core.get_grid_data('TRIP_ID');
        rec.trip_name       := core.get_grid_data('TRIP_NAME');
        rec.start_at        := core.get_date(core.get_grid_data('START_AT'));
        rec.end_at          := core.get_date(core.get_grid_data('END_AT'));
        --
        TRP_TAPI.save_trips (rec,
            in_action           => in_action,
            in_trip_id          => NVL(core.get_grid_data('OLD_TRIP_ID'), rec.trip_id)
        );
        --
        IF in_action = 'D' THEN
            RETURN;     -- exit this procedure
        END IF;

        -- update primary key back to APEX grid for proper row refresh
        core.set_grid_data('OLD_TRIP_ID',       rec.trip_id);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



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
        rec.is_reserved     := core.get_grid_data('IS_RESERVED');
        rec.is_paid         := core.get_grid_data('IS_PAID');
        rec.is_pending      := core.get_grid_data('IS_PENDING');
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



    PROCEDURE save_categories
    AS
        rec                     trp_categories%ROWTYPE;
        in_action               CONSTANT CHAR := core.get_grid_action();
    BEGIN
        -- change record in table
        rec.category_id         := core.get_grid_data('CATEGORY_ID');
        rec.category_name       := core.get_grid_data('CATEGORY_NAME');
        rec.order#              := core.get_grid_data('ORDER#');
        rec.color_fill          := core.get_grid_data('COLOR_FILL');
        --
        TRP_TAPI.save_categories (rec,
            in_action               => in_action,
            in_category_id          => NVL(core.get_grid_data('OLD_CATEGORY_ID'), rec.category_id)
        );
        --
        IF in_action = 'D' THEN
            RETURN;     -- exit this procedure
        END IF;

        -- update primary key back to APEX grid for proper row refresh
        core.set_grid_data('OLD_CATEGORY_ID',       rec.category_id);
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE set_defaults
    AS
    BEGIN
        FOR c IN (
            SELECT
                t.trip_id,
                t.trip_name,
                t.start_at,
                t.end_at + 1 AS end_at
            FROM trp_trips t
            WHERE t.trip_id = core.get_number_item('P100_TRIP_ID')
        ) LOOP
            core.set_item('P100_TRIP_NAME',     c.trip_name);
            core.set_item('P100_TRIP_START',    TO_CHAR(c.start_at, 'YYYY-MM-DD'));
            core.set_item('P100_TRIP_END',      TO_CHAR(c.end_at,   'YYYY-MM-DD'));
            --
            FOR d IN (
                SELECT SUM(price) AS trip_price
                FROM trp_itinerary
                WHERE trip_id = c.trip_id
            ) LOOP
                core.set_item('P100_TRIP_PRICE', d.trip_price);
            END LOOP;
        END LOOP;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;



    PROCEDURE set_days
    AS
        v_day               DATE := core.get_date_item('P100_DAY', 'YYYY-MM-DD');
        v_day_prev          DATE;
        v_day_next          DATE;
        v_day_prev_limit    DATE;
        v_day_next_limit    DATE;
    BEGIN
        -- get boundaries
        SELECT MIN(t.start_at), MAX(t.end_at)
        INTO v_day_prev_limit, v_day_next_limit
        FROM trp_trips t
        WHERE t.trip_id     = core.get_item('P100_TRIP_ID');

        -- set starting date
        IF v_day IS NULL THEN
            --v_day := v_day_prev_limit;
            NULL;
        END IF;

        -- check boundaries
        v_day := LEAST(GREATEST(v_day, v_day_prev_limit), v_day_next_limit);

        -- calculate prev/next dates
        v_day_prev := v_day - 1;
        IF v_day_prev < v_day_prev_limit THEN
            v_day_prev := NULL;
        END IF;
        IF v_day_prev IS NULL AND v_day IS NULL THEN
            v_day_prev := v_day_prev_limit;
        END IF;
        --
        v_day_next := v_day + 1;
        IF v_day_next > v_day_next_limit THEN
            v_day_next := NULL;
        END IF;

        -- set items
        core.set_item('P100_DAY',       CASE WHEN v_day       IS NOT NULL THEN core.get_date(v_day,       'YYYY-MM-DD') END);
        core.set_item('P100_DAY_PREV',  CASE WHEN v_day_prev  IS NOT NULL THEN core.get_date(v_day_prev,  'YYYY-MM-DD') END);
        core.set_item('P100_DAY_NEXT',  CASE WHEN v_day_next  IS NOT NULL THEN core.get_date(v_day_next,  'YYYY-MM-DD') END);
        --
        core.set_item('P100_DAY_PREV_ATTR',  CASE WHEN v_day_prev  IS NULL THEN ' disabled="disabled"' END);
        core.set_item('P100_DAY_NEXT_ATTR',  CASE WHEN v_day_next  IS NULL THEN ' disabled="disabled"' END);
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
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

