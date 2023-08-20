CREATE OR REPLACE PACKAGE BODY trp_app as

    PROCEDURE save_trips
    AS
        rec                 trp_trips%ROWTYPE;
        in_action           CONSTANT CHAR := core.get_grid_action();
    BEGIN
        -- change record in table
        IF core.get_page_id() = 105 THEN
            rec.trip_id         := core.get_number_item('$TRIP_ID');
            rec.trip_name       := core.get_item('$TRIP_NAME');
            rec.start_at        := core.get_date_item('$START_AT');
            rec.end_at          := core.get_date_item('$END_AT');
        ELSE
            rec.trip_id         := core.get_grid_data('TRIP_ID');
            rec.trip_name       := core.get_grid_data('TRIP_NAME');
            rec.start_at        := core.get_date(core.get_grid_data('START_AT'));
            rec.end_at          := core.get_date(core.get_grid_data('END_AT'));
        END IF;
        --
        trp_tapi.save_trips (rec,
            in_action           => in_action,
            in_trip_id          => NVL(core.get_grid_data('OLD_TRIP_ID'), rec.trip_id)
        );
        --
        IF in_action = 'D' THEN
            RETURN;     -- exit this procedure
        END IF;

        -- update primary key back to APEX grid for proper row refresh
        IF core.get_page_id() = 105 THEN
            core.set_item('$TRIP_ID', rec.trip_id);
        ELSE
            core.set_grid_data('OLD_TRIP_ID',       rec.trip_id);
        END IF;
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
        IF core.get_page_id() = 110 THEN
            rec.trip_id         := core.get_number_item('$TRIP_ID');
            rec.stop_id         := core.get_number_item('$STOP_ID');
            rec.stop_name       := core.get_item('$STOP_NAME');
            rec.category_id     := core.get_item('$CATEGORY_ID');
            rec.price           := core.get_number_item('$PRICE');
            rec.notes           := core.get_item('$NOTES');
            rec.color_fill      := core.get_item('$COLOR_FILL');
            rec.link_reservation := core.get_item('$LINK_RESERVATION');
            rec.link_event      := core.get_item('$LINK_EVENT');
            rec.is_reserved     := NULLIF(core.get_item('$IS_RESERVED'), 'N');
            rec.is_paid         := NULLIF(core.get_item('$IS_PAID'), 'N');
            rec.is_pending      := NULLIF(core.get_item('$IS_PENDING'), 'N');
            rec.start_at        := core.get_date_item('$START_AT');
            rec.end_at          := core.get_date_item('$END_AT');
        ELSE
            rec.trip_id         := core.get_grid_data('TRIP_ID');
            rec.stop_id         := core.get_grid_data('STOP_ID');
            rec.stop_name       := core.get_grid_data('STOP_NAME');
            rec.category_id     := core.get_grid_data('CATEGORY_ID');
            rec.price           := core.get_grid_data('PRICE');
            rec.notes           := core.get_grid_data('NOTES');
            rec.color_fill      := core.get_grid_data('COLOR_FILL');
            rec.link_reservation := core.get_grid_data('LINK_RESERVATION');
            rec.link_event      := core.get_grid_data('LINK_EVENT');
            rec.is_reserved     := core.get_grid_data('IS_RESERVED');
            rec.is_paid         := core.get_grid_data('IS_PAID');
            rec.is_pending      := core.get_grid_data('IS_PENDING');
            rec.start_at        := core.get_date(core.get_grid_data('START_AT'));
            rec.end_at          := core.get_date(core.get_grid_data('END_AT'));
        END IF;
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
        IF core.get_page_id() = 110 THEN
            core.set_item('$TRIP_ID', rec.trip_id);
            core.set_item('$STOP_ID', rec.stop_id);
        ELSE
            core.set_grid_data('OLD_TRIP_ID',       rec.trip_id);
            core.set_grid_data('OLD_STOP_ID',       rec.stop_id);
        END IF;
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
        rec.is_lov              := core.get_grid_data('IS_LOV');
        --
        trp_tapi.save_categories (rec,
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
        in_trip_id              CONSTANT trp_trips.trip_id%TYPE := core.get_number_item('P100_TRIP_ID');
        --
        v_recent_trip_id        trp_trips.trip_id%TYPE;
        v_trip_header           VARCHAR2(256);
        v_itinerary_header      VARCHAR2(256);
    BEGIN
        -- redirect to recent trip
        IF in_trip_id IS NULL AND INSTR(core.get_request_url(), 'clear=100') = 0 THEN
            v_recent_trip_id := APEX_UTIL.GET_PREFERENCE (
                p_preference    => 'RECENT_TRIP',
                p_user          => core.get_user_id()
            );
            --
            IF v_recent_trip_id IS NOT NULL THEN
                core.redirect (
                    in_page_id      => 100,
                    in_names        => 'P100_TRIP_ID',
                    in_values       => v_recent_trip_id,
                    in_reset        => 'Y'
                );
                RETURN; -- we will be redirecting anyway
            END IF;
        END IF;

        -- prefill default values
        FOR c IN (
            SELECT
                t.trip_id,
                t.trip_name,
                t.start_at,
                t.end_at + 1    AS end_at,
                SUM(price)      AS price
                --
            FROM trp_trips t
            LEFT JOIN trp_itinerary i
                ON i.trip_id    = t.trip_id
                AND (i.start_at >= core.get_date_item('P100_DAY')       OR core.get_date_item('P100_DAY') IS NULL)
                AND (i.end_at   < core.get_date_item('P100_DAY') + 1    OR core.get_date_item('P100_DAY') IS NULL OR i.end_at IS NULL)
            WHERE t.trip_id     = in_trip_id
            GROUP BY
                t.trip_id,
                t.trip_name,
                t.start_at,
                t.end_at + 1
        ) LOOP
            core.set_item('P100_TRIP_HEADER',   c.trip_name);
            core.set_item('P100_TRIP_START',    TO_CHAR(c.start_at, 'YYYY-MM-DD'));
            core.set_item('P100_TRIP_END',      TO_CHAR(c.end_at,   'YYYY-MM-DD'));
            --
            v_trip_header       := c.trip_name;
            v_itinerary_header  := RTRIM('Itinerary - ' || core.get_item('P100_DAY'), ' - ') || NULLIF(' [' || c.price || ']', ' [0]');
        END LOOP;
        --
        core.set_item('P100_TRIP_HEADER',       REPLACE(v_trip_header,      ' - ', ' &' || 'ndash; '));
        core.set_item('P100_ITINERARY_HEADER',  REPLACE(v_itinerary_header, ' - ', ' &' || 'ndash; '));
        core.set_item('P100_RECENT_TRIP_URL',   '');

        -- store current trip for redirection after login
        IF in_trip_id IS NOT NULL THEN
            APEX_UTIL.SET_PREFERENCE (
                p_preference    => 'RECENT_TRIP',
                p_value         => in_trip_id,
                p_user          => core.get_user_id()
            );
        END IF;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN APEX_APPLICATION.E_STOP_APEX_ENGINE THEN
        NULL;
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
        core.set_item('P100_DAY_ATTR',      CASE WHEN v_day       IS NULL THEN ' disabled="disabled"' END);
        core.set_item('P100_DAY_PREV_ATTR', CASE WHEN v_day_prev  IS NULL THEN ' disabled="disabled"' END);
        core.set_item('P100_DAY_NEXT_ATTR', CASE WHEN v_day_next  IS NULL THEN ' disabled="disabled"' END);
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
            FROM trp_itinerary_grid_v t
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



    PROCEDURE after_auth
    AS
    BEGIN
        NULL;
    EXCEPTION
    WHEN core.app_exception THEN
        RAISE;
    WHEN APEX_APPLICATION.E_STOP_APEX_ENGINE THEN
        NULL;
    WHEN OTHERS THEN
        core.raise_error();
    END;

END;
/

