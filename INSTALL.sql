--
-- INIT
--
@@"../../patches/10_init/01_init.sql"

--
-- TABLES
--
@@"../../database/tables/trp_categories.sql"
@@"../../database/tables/trp_trips.sql"
@@"../../database/tables/trp_itinerary.sql"

--
-- OBJECTS
--
@@"../../database/packages/trp_api.spec.sql"
@@"../../database/packages/trp_tapi.spec.sql"
@@"../../database/views/trp_itinerary_grid_v.sql"
@@"../../database/views/trp_itinerary_v.sql"
@@"../../database/packages/trp_api.sql"
@@"../../database/packages/trp_tapi.sql"

--
-- FINALLY
--
@@"../../patches/90_finally/98_checks.sql"
@@"../../patches/90_finally/96_stats.sql"
@@"../../patches/90_finally/94_indexes.sql"
@@"../../patches/90_finally/90_recompile.sql"
@@"../../patches/90_finally/92_refresh_mvw.sql"

--
-- APEX
--
@@"../../database/apex/f765/f765.sql"

