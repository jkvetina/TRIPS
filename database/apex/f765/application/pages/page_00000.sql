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
,p_step_title=>'Global Page'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
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
'',
'//',
'// WAIT FOR ELEMENT TO EXIST',
'//',
'var wait_for_element = function(search, start, fn, disconnect) {',
'    var ob  = new MutationObserver(function(mutations) {',
'        if ($(search).length) {',
'            fn(search, start);',
'            if (disconnect) {',
'                observer.disconnect();  // keep observing',
'            }',
'        }',
'    });',
'    //',
'    ob.observe(document.getElementById(start), {',
'        childList: true,',
'        subtree: true',
'    });',
'};',
'',
'//',
'// HIDE SUCCESS MESSAGE',
'//',
'var hide_success_message = function(search, start) {',
'    var $start = $(''#'' + start);',
'    //',
'    setTimeout(function() {',
'        apex.message.hidePageSuccess();  // hide message',
'        var content = $start.text().trim();',
'        if (content.length) {',
'            console.log(''MESSAGE CLOSED:'', content);',
'        }',
'        $start.html('''').removeClass(''u-visible'');  // clean APEX mess',
'    }, 2000);',
'};',
'',
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
'',
'ul.DASH_LIST {',
'  list-style-type: none;',
'  margin: 0.5rem 0 0.5rem 3rem;',
'}',
'ul.DASH_LIST li:before {',
'  content: ''\2014'';',
'  position: absolute;',
'  margin: 0 3rem 0 -1.5rem;',
'}',
'',
'</style>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp.component_end;
end;
/
