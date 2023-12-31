BEGIN
    DBMS_OUTPUT.PUT_LINE('--');
    DBMS_OUTPUT.PUT_LINE('-- MERGE ' || UPPER('trp_categories'));
    DBMS_OUTPUT.PUT_LINE('--');
END;
/
--
DELETE FROM trp_categories;
--
MERGE INTO trp_categories t
USING (
    SELECT '?' AS category_id, '?' AS category_name, 25 AS order#, '#8b6e28' AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'AIRPLANE' AS category_id, 'Airplane' AS category_name, 10 AS order#, '#686461' AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'CAR_RENTAL' AS category_id, 'Car Rental' AS category_name, 35 AS order#, '#e7eaef' AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'EVENT' AS category_id, 'Event #1' AS category_name, 40 AS order#, '#84a02b' AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'EVENT2' AS category_id, 'Event #2' AS category_name, 42 AS order#, '#a5a831' AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'EVENT3' AS category_id, 'Event #3' AS category_name, 43 AS order#, '#ffffff' AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'EVENT4' AS category_id, 'Event #4' AS category_name, 44 AS order#, '#ffffff' AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'EXPENSE' AS category_id, 'Expense (cost tracking only)' AS category_name, NULL AS order#, NULL AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'HOTEL' AS category_id, 'Hotel' AS category_name, 30 AS order#, '#e7eaef' AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'ROADTRIP' AS category_id, 'Roadtrip' AS category_name, 36 AS order#, '#cfdbda' AS color_fill, 'Y' AS is_lov FROM DUAL UNION ALL
    SELECT 'STATUS_PAID' AS category_id, 'Paid' AS category_name, NULL AS order#, '#778d45' AS color_fill, NULL AS is_lov FROM DUAL UNION ALL
    SELECT 'STATUS_PENDING' AS category_id, 'Pending' AS category_name, NULL AS order#, '#e7242d' AS color_fill, NULL AS is_lov FROM DUAL UNION ALL
    SELECT 'STATUS_RESERVED' AS category_id, 'Reserved' AS category_name, NULL AS order#, '#f7c815' AS color_fill, NULL AS is_lov FROM DUAL UNION ALL
    SELECT 'STATUS_UNKNOWN' AS category_id, 'Unknown' AS category_name, NULL AS order#, '#ffffff' AS color_fill, NULL AS is_lov FROM DUAL UNION ALL
    SELECT 'TRANSFER' AS category_id, 'Transfer' AS category_name, 20 AS order#, '#ffffff' AS color_fill, 'Y' AS is_lov FROM DUAL
) s
ON (
    t.category_id = s.category_id
)
--WHEN MATCHED THEN
--    UPDATE SET
--        t.category_name = s.category_name,
--        t.order# = s.order#,
--        t.color_fill = s.color_fill,
--        t.is_lov = s.is_lov
WHEN NOT MATCHED THEN
    INSERT (
        t.category_id,
        t.category_name,
        t.order#,
        t.color_fill,
        t.is_lov
    )
    VALUES (
        s.category_id,
        s.category_name,
        s.order#,
        s.color_fill,
        s.is_lov
    );
