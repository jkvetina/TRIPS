CREATE OR REPLACE PACKAGE trp_app as

    PROCEDURE save_itinerary;



    PROCEDURE set_days;



    FUNCTION set_colors
    RETURN CLOB;

END;
/

