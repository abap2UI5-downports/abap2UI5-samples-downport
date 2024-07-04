class z2ui5_cl_demo_app_217 definition
  public
  create public .

public section.

  interfaces IF_SERIALIZABLE_OBJECT .
  interfaces Z2UI5_IF_APP .

  data CHECK_INITIALIZED type ABAP_BOOL .
  PROTECTED SECTION.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_217 IMPLEMENTATION.


  METHOD DISPLAY_VIEW.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Placing a Title in OverflowToolbar/Toolbar'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    
    layout = page->overflow_toolbar( design  = `Transparent` height = `3rem`
                          )->title( text = `Title Only` ).
                   page->overflow_toolbar( design  = `Transparent` height = `3rem`
                          )->title( text = `Title and Actions`
                          )->toolbar_spacer(
                          )->button( icon = `sap-icon://group-2`
                          )->button( icon = `sap-icon://action-settings` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD ON_EVENT.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.


  METHOD Z2UI5_IF_APP~MAIN.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.
