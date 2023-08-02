CREATE OR REPLACE PACKAGE trp_app as

    PROCEDURE save_trips;



    PROCEDURE save_itinerary;



    PROCEDURE save_categories;



    PROCEDURE set_defaults;



    PROCEDURE set_days;



    FUNCTION set_colors
    RETURN CLOB;

END;
/

