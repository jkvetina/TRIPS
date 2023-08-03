prompt --application/pages/page_groups
begin
--   Manifest
--     PAGE GROUPS: 765
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>765
,p_default_id_offset=>59434108571287006
,p_default_owner=>'APPS'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(53536909635676125)  --  MAIN
,p_group_name=>' MAIN'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(53537085390676579)  -- ADMIN
,p_group_name=>'ADMIN'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(9775084414340395)  -- _ABOUT
,p_group_name=>'_ABOUT'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(9548806082891001)  -- _INTERNAL
,p_group_name=>'_INTERNAL'
);
wwv_flow_imp.component_end;
end;
/
