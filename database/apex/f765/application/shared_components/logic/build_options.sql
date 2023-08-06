prompt --application/shared_components/logic/build_options
begin
--   Manifest
--     BUILD OPTIONS: 765
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.2'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>765
,p_default_id_offset=>59434108571287006
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(9485802364129179)
,p_build_option_name=>'NEVER'
,p_build_option_status=>'EXCLUDE'
);
wwv_flow_imp.component_end;
end;
/
