prompt --application/shared_components/user_interface/lovs/lov_categories
begin
--   Manifest
--     LOV_CATEGORIES
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.2'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>765
,p_default_id_offset=>59434108571287006
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(9328123487143807)  -- LOV_CATEGORIES
,p_lov_name=>'LOV_CATEGORIES'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'TRP_CATEGORIES'
,p_return_column_name=>'CATEGORY_ID'
,p_display_column_name=>'CATEGORY_NAME'
,p_default_sort_column_name=>'CATEGORY_NAME'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
