prompt --application/pages/page_00000
begin
--   Manifest
--     PAGE: 00000
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>765
,p_default_id_offset=>59434108571287006
,p_default_owner=>'APPS'
);
wwv_flow_imp_page.create_page(
 p_id=>0
,p_name=>'Global Page'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(9548806082891001)  -- _INTERNAL
,p_protection_level=>'D'
,p_page_component_map=>'14'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20220101000000'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(59524795046840556)
,p_plug_name=>'JS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(45418266646075228)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BEFORE_FOOTER'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<script>',
'</script>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(73925045359998828)
,p_plug_name=>'CSS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(45418266646075228)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BEFORE_FOOTER'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>',
'</style>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(9333090540174736)
,p_name=>'AUTOHIDE_SUCCESS'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9333163652174737)
,p_event_id=>wwv_flow_imp.id(9333090540174736)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.theme42.util.configAPEXMsgs({',
'    autoDismiss : true,',
'    duration    : 2000',
'});'))
);
wwv_flow_imp.component_end;
end;
/
