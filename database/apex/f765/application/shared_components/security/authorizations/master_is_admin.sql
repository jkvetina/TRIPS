prompt --application/shared_components/security/authorizations/master_is_admin
begin
--   Manifest
--     SECURITY SCHEME: MASTER - IS_ADMIN
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>765
,p_default_id_offset=>59434108571287006
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(45845471700274026)  -- MASTER - IS_ADMIN
,p_name=>'MASTER - IS_ADMIN'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>'RETURN FALSE;'
,p_error_message=>'ACCESS_DENIED|ADMIN'
,p_reference_id=>38537511032053456
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_imp.component_end;
end;
/
