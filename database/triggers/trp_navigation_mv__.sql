CREATE OR REPLACE TRIGGER trp_navigation_mv__
AFTER INSERT OR UPDATE OR DELETE ON trp_navigation
BEGIN
    core.create_job (
        in_job_name     => 'TRP_NAVIGATION_MV_?',   -- dynamic name
        in_statement    => 'BEGIN core.refresh_mviews(''TRP_NAVIGATION_MAP_MV''); END;'
    );
END;
/

