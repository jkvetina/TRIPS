CREATE OR REPLACE FORCE VIEW trp_navigation_top_v AS
WITH curr AS (
    -- current context
    SELECT /*+ MATERIALIZE */
        core.get_app_id()   AS app_id,
        n.page_id,
        n.parent_id,
        core.get_page_group(n.page_id)          AS page_group,
        core.get_user_id()                      AS user_id,
        NVL(u.user_name, core.get_user_id())    AS user_name
    FROM trp_navigation n
    LEFT JOIN trp_users u
        ON u.user_id        = core.get_user_id()
        AND u.is_active     = 'Y'
    WHERE n.page_id         = core.get_page_id()
),
t AS (
    -- available pages
    SELECT /*+ MATERIALIZE */
        curr.app_id     AS app_id,
        curr.app_id     AS curr_app_id,
        curr.user_name  AS user_name,
        --
        n.page_id,
        n.parent_id,
        --
        s.page_alias,
        core.get_page_name(in_name => s.page_name) AS page_name,
        s.auth_scheme,
        n.is_reset,
        n.order#
    FROM trp_navigation n
    CROSS JOIN curr
    JOIN trp_navigation_map_mv s
        ON s.app_id         = curr.app_id
        AND s.page_id       = n.page_id
        AND n.is_hidden     IS NULL
    WHERE 1 = 1
    /*
        AND 'Y' = trp_auth.is_page_available (
            in_user_id          => curr.user_id,
            in_page_id          => s.page_id,
            in_client_id        => curr.client_id,
            in_project_id       => curr.project_id,
            in_auth_scheme      => s.auth_scheme,
            in_procedure_name   => s.procedure_name
        )*/
    --
    UNION ALL
    SELECT              -- append launchpad icon/link
        700             AS app_id,
        curr.app_id     AS curr_app_id,
        curr.user_name  AS user_name,
        --
        100             AS page_id,
        NULL            AS parent_id,
        'HOME'          AS page_alias,
        --
        '<span class="fa fa-navicon"></span>' AS page_name,
        --
        NULL            AS auth_scheme,
        'Y'             AS is_reset,
        -1000           AS order#
    FROM curr
),
n AS (
    -- build the tree
    SELECT /*+ MATERIALIZE */
        CASE WHEN t.parent_id IS NULL THEN 1 ELSE 2 END AS lvl,
        --
        CASE
            WHEN t.page_id = 0      THEN '</li></ul><ul class="empty"></ul><ul><li>'
            ELSE REPLACE(t.page_name, '&' || 'APP_USER.', t.user_name)
            END AS label,
        CASE
            WHEN t.page_id = 9999   THEN '&' || 'LOGOUT_URL.'
            WHEN t.page_id > 0      THEN
                APEX_PAGE.GET_URL (
                    p_application   => t.app_id,
                    p_page          => NVL(t.page_alias, t.page_id),
                    p_clear_cache   => CASE WHEN t.is_reset = 'Y' THEN t.page_id END
                )
            END AS target,
        --
        CASE
            WHEN t.app_id = t.curr_app_id AND t.page_id = (SELECT page_id   FROM curr)  THEN 'YES'
            WHEN t.app_id = t.curr_app_id AND t.page_id = (SELECT parent_id FROM curr)  THEN 'YES'
            END AS is_current_list_entry,
        --
        NULL                    AS image,
        NULL                    AS image_attribute,
        NULL                    AS image_alt_attribute,
        --
        CASE
            WHEN t.page_id = 900 THEN 'RIGHT'
            END AS attribute01,
        --
        NULL                    AS attribute02,             -- li.class
        --
        CASE
            WHEN t.page_id = 0  THEN '" style="display: none;'
            END AS attribute03,     -- a.class
        --
        NULL                    AS attribute04,
        NULL                    AS attribute05,
        NULL                    AS attribute06,
        NULL                    AS attribute07,
        NULL                    AS attribute08,
        NULL                    AS attribute09,
        NULL                    AS attribute10,
        --
        t.page_id,
        t.parent_id,
        t.auth_scheme,
        --
        SYS_CONNECT_BY_PATH(t.order# || '.' || t.page_id, '/') AS order#,
        --
        REPLACE(RPAD(' ', (LEVEL - 1) * 4, ' '), ' ', '&' || 'nbsp; ') || t.page_name AS label__
    FROM t
    CONNECT BY t.app_id         = PRIOR t.app_id
        AND t.parent_id         = PRIOR t.page_id
    START WITH t.parent_id      IS NULL
    ORDER SIBLINGS BY t.order# NULLS LAST, t.page_id
)
SELECT
    n.lvl,
    n.label,
    n.target,
    n.is_current_list_entry,
    n.image,
    n.image_attribute,
    n.image_alt_attribute,
    n.attribute01,          -- <li class="...">
    n.attribute02,          -- <li>...<a>
    n.attribute03,          -- <a class="..."
    n.attribute04,          -- <a title="..."
    n.attribute05,          -- <a ...> // javascript onclick
    n.attribute06,          -- <a>... #TEXT</a>
    n.attribute07,          -- <a>#TEXT ...</a>
    n.attribute08,          -- </a>...
    n.attribute09,
    n.attribute10,
    n.page_id,
    n.parent_id,
    n.auth_scheme,
    n.label__,
    n.order#
FROM n
UNION ALL
--
SELECT                      -- append favorite boards
    2 AS lvl,
    REPLACE(t.trip_name, ' - ', ' &' || 'ndash; ') AS label,
    --
    APEX_PAGE.GET_URL (
        p_application       => curr.app_id,
        p_page              => 100,--curr.page_id,
        p_clear_cache       => 100,
        p_items             => 'P100_TRIP_ID',
        p_values            => t.trip_id
    ) AS target,
    --
    NULL AS is_current_list_entry,
    NULL AS image,
    NULL AS image_attribute,
    NULL AS image_alt_attribute,
    NULL AS attribute01,
    NULL AS attribute02,
    NULL AS attribute03,
    NULL AS attribute04,
    NULL AS attribute05,
    --'<span class="fa fa-heart-o"></span> &' || 'nbsp;'
    NULL AS attribute06,
    NULL AS attribute07,
    NULL AS attribute08,
    NULL AS attribute09,
    NULL AS attribute10,
    NULL AS page_id,
    NULL AS parent_id,
    NULL AS auth_scheme,
    NULL AS label__,
    '/100.100/' || LPAD(ROW_NUMBER() OVER (ORDER BY t.start_at, t.end_at, t.trip_id), 8, '0') AS order#
FROM trp_trips t
CROSS JOIN curr
WHERE 1 = 1
    AND UPPER(curr.user_id) = t.created_by;
--
COMMENT ON TABLE trp_navigation_top_v IS '';

