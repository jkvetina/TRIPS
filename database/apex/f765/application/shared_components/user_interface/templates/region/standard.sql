prompt --application/shared_components/user_interface/templates/region/standard
begin
--   Manifest
--     REGION TEMPLATE: STANDARD
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.2'
,p_default_workspace_id=>8506563800894011
,p_default_application_id=>765
,p_default_id_offset=>59434108571287006
,p_default_owner=>'APPS'
);
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(45484274708075270)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading" data-apex-heading>#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     #ORDER_BY_ITEM#',
'     #BODY#',
'     #SUB_REGIONS#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>',
''))
,p_page_plug_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>700
,p_theme_class_id=>8
,p_preset_template_options=>'t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_reference_id=>37975833283322342
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49267810686406134)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49268261072406134)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Change'
,p_placeholder=>'CHANGE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49268819216406134)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49269292214406134)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Copy'
,p_placeholder=>'COPY'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49269749252406135)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49270268613406135)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Delete'
,p_placeholder=>'DELETE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49270775536406135)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49271324205406135)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Help'
,p_placeholder=>'HELP'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49271828979406136)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49272276034406136)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Sort Order'
,p_placeholder=>'ORDER_BY_ITEM'
,p_has_grid_support=>true
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49272772879406136)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(49273242397406137)
,p_plug_template_id=>wwv_flow_imp.id(45484274708075270)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp.component_end;
end;
/
