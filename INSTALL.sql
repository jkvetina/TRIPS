--
-- YOU HAVE TO INSTALL THE CORE PACKAGE FIRST
-- https://github.com/jkvetina/CORE23/tree/main/database
--
--             SEQUENCE | TRP_STOP_ID                                        [+]
--                      | TRP_TRIP_ID                                        [+]
--                      |
--                TABLE | TRP_CATEGORIES                                     [+]
--                      | TRP_ITINERARY                                      [+]
--                      | TRP_NAVIGATION                                     [+]
--                      | TRP_TRIPS                                          [+]
--                      | TRP_USERS                                          [+]
--                      |
--                 VIEW | TRP_CATEGORIES_GRID_V                              [+]
--                      | TRP_ITINERARY_GANTT_V                              [+]
--                      | TRP_ITINERARY_GRID_V                               [+]
--                      | TRP_ITINERARY_V                                    [+]
--                      | TRP_LOV_CATEGORIES_V                               [+]
--                      | TRP_NAVIGATION_TOP_V                               [+]
--                      | TRP_TRIPS_GRID_V                                   [+]
--                      |
--              PACKAGE | TRP_APP                                            [+]
--                      | TRP_TAPI                                           [+]
--                      |
--         PACKAGE BODY | TRP_APP                                            [+]
--                      | TRP_TAPI                                           [+]
--                      |
--              TRIGGER | TRP_NAVIGATION_MV__                                [+]
--                      |
--    MATERIALIZED VIEW | TRP_NAVIGATION_MAP_MV                              [+]
--                      |

--
-- INIT
--
@@"./patches/10_init/01_init.sql"

--
-- SEQUENCES
--
@@"./database/sequences/trp_stop_id.sql"
@@"./database/sequences/trp_trip_id.sql"

--
-- TABLES
--
@@"./database/tables/trp_categories.sql"
@@"./database/tables/trp_trips.sql"
@@"./database/tables/trp_users.sql"
@@"./database/tables/trp_navigation.sql"
@@"./database/tables/trp_itinerary.sql"

--
-- OBJECTS
--
@@"./database/views/trp_itinerary_v.sql"
@@"./database/packages/trp_app.spec.sql"
@@"./database/views/trp_categories_grid_v.sql"
@@"./database/views/trp_lov_categories_v.sql"
@@"./database/views/trp_itinerary_grid_v.sql"
@@"./database/views/trp_trips_grid_v.sql"
@@"./database/packages/trp_tapi.spec.sql"
@@"./database/views/trp_navigation_top_v.sql"
@@"./database/views/trp_itinerary_gantt_v.sql"
@@"./database/packages/trp_app.sql"
@@"./database/packages/trp_tapi.sql"

--
-- TRIGGERS
--
@@"./database/triggers/trp_navigation_mv__.sql"

--
-- MVIEWS
--
@@"./patches/50_mviews/50_recompile.sql"
--
@@"./database/mviews/trp_navigation_map_mv.sql"

--
-- INDEXES
--
@@"./patches/55_indexes/50_recompile.sql"

--
-- DATA
--
@@"./patches/60_data/trp_categories.sql"
@@"./patches/60_data/trp_navigation.sql"
--
COMMIT;

--
-- FINALLY
--
@@"./patches/90_finally/98_checks.sql"
@@"./patches/90_finally/96_stats.sql"
@@"./patches/90_finally/94_indexes.sql"
@@"./patches/90_finally/90_recompile.sql"
@@"./patches/90_finally/92_refresh_mvw.sql"

--
-- APEX
--
@@"./database/apex/f765/f765.sql"

