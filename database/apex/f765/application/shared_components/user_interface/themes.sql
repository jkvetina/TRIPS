prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 765
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>765
,p_default_id_offset=>59434108571287006
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(45560154874075332)
,p_theme_id=>700
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>38080028704322422
,p_is_locked=>false
,p_default_page_template=>wwv_flow_imp.id(49075986562405994)
,p_default_dialog_template=>wwv_flow_imp.id(45399604373075215)
,p_error_template=>wwv_flow_imp.id(45389606943075209)
,p_printer_friendly_template=>wwv_flow_imp.id(45404835659075218)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_imp.id(45389606943075209)
,p_default_button_template=>wwv_flow_imp.id(45557146799075321)
,p_default_region_template=>wwv_flow_imp.id(45418266646075228)
,p_default_chart_template=>wwv_flow_imp.id(45484274708075270)
,p_default_form_template=>wwv_flow_imp.id(45484274708075270)
,p_default_reportr_template=>wwv_flow_imp.id(45484274708075270)
,p_default_tabform_template=>wwv_flow_imp.id(45484274708075270)
,p_default_wizard_template=>wwv_flow_imp.id(45484274708075270)
,p_default_menur_template=>wwv_flow_imp.id(45496718564075277)
,p_default_listr_template=>wwv_flow_imp.id(45484274708075270)
,p_default_irr_template=>wwv_flow_imp.id(45474496779075265)
,p_default_report_template=>wwv_flow_imp.id(45522183779075295)
,p_default_label_template=>wwv_flow_imp.id(45554742274075318)
,p_default_menu_template=>wwv_flow_imp.id(45558761403075323)
,p_default_calendar_template=>wwv_flow_imp.id(45558869541075324)
,p_default_list_template=>wwv_flow_imp.id(45538550809075306)
,p_default_nav_list_template=>wwv_flow_imp.id(45550379672075315)
,p_default_top_nav_list_temp=>wwv_flow_imp.id(45550379672075315)
,p_default_side_nav_list_temp=>wwv_flow_imp.id(45545042118075311)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_imp.id(45421123092075232)
,p_default_dialogr_template=>wwv_flow_imp.id(45418266646075228)
,p_default_option_label=>wwv_flow_imp.id(45554742274075318)
,p_default_required_label=>wwv_flow_imp.id(45556006586075319)
,p_default_navbar_list_template=>wwv_flow_imp.id(45544599987075310)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(700),'#APEX_FILES#themes/theme_42/22.2/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_FILES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_FILES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_imp.component_end;
end;
/
