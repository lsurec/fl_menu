// ignore_for_file: use_build_context_synchronously

import 'package:fl_menu/models/models.dart';
import 'package:fl_menu/services/menu_service.dart';
import 'package:fl_menu/services/notification_service.dart';
import 'package:flutter/material.dart';

class MenuViewModel extends ChangeNotifier {
  //control del proceso
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //Lista que se muestra en pantalla
  final List<MenuModel> menuActive = [];
  //lista de navegacion (Nodos que se han miviso)
  final List<MenuModel> routeMenu = [];
  //menu completo
  late List<MenuModel> menu = [];

  //tipo docuento
  int? documento;
  String name = "";
  String? docuentoName;

  //navegar a ruta
  void navigateDisplay(
    BuildContext context,
    String route,
    int? tipoDocumento,
    String nameDisplay,
    String? docName,
  ) {
    //asiganro valores para la pantalla
    documento = tipoDocumento;
    name = nameDisplay;
    docuentoName = docName;
    Navigator.pushNamed(context, route);
  }

  //Cambiar la lista que se muestra en pantalla
  void changeMenuActive(List<MenuModel> active, MenuModel padre) {
    //limpiar lista que se muestra
    menuActive.clear();
    //Agreagr nuevo contenido a la lista
    menuActive.addAll(active);
    //Agregar padre a la navehacion
    routeMenu.add(padre);
    //Notificar a los clientes
    notifyListeners();
  }

  //Cambiar rutas (Agreagar)
  void changeRoute(int index) {
    //Si el indice del padre seleccionado es menor al total de itemes
    //eliminar todos los qe sigan a partir del indice seleccoinado
    if (routeMenu.length - 1 > index) {
      //Eliminar el ultimo indice
      routeMenu.removeAt(routeMenu.length - 1);
      //Eliminar lo que se esta mostrando
      menuActive.clear();
      //Agreagar nuevo contenido
      menuActive.addAll(routeMenu[index].children);
      //notificar a los clientes
      notifyListeners();
      //Repetir hasta que todos los indices de mas se eliminen
      changeRoute(index);
    }
  }

  //actualizar menu
  Future<void> refreshData(BuildContext context) async {
    isLoading = true;
    await loadDataMenu(context);
    isLoading = false;
  }

  //cargar menu
  Future<void> loadDataMenu(BuildContext context) async {
    //limmpiar listas que se usan
    menuActive.clear();
    routeMenu.clear();
    menu.clear();

    //view model externo

    //Lista aplicaciones y displays ()
    late List<MenuData> menuData = [];

    List<Map<String, dynamic>> appsMap = [
      {
        "application": 6,
        "application_Father": 1,
        "description": "Compras",
        "observacion_1": "Compras"
      },
      {
        "application": 16,
        "application_Father": 1,
        "description": "Inventario",
        "observacion_1": "Inventario"
      },
      {
        "application": 2,
        "application_Father": 1,
        "description": "Punto de Venta",
        "observacion_1": "Punto de Venta"
      }
    ];

    ///asiganr aplicacviones
    List<ApplicationModel> applications =
        appsMap.map((json) => ApplicationModel.fromMap(json)).toList();

    //Si menu data tiene datos anteriores limpiar la lista
    menuData.clear();

    //Guardar en menu datos applicaciones y displays sin ordenar
    for (var application in applications) {
      menuData.add(MenuData(application: application, children: []));
    }

    List<Map<String, dynamic>> firstMap = [
      {
        "user_Display": 73924,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Reporte",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 6,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 64809,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73925,
        "user_Display_Father": 73924,
        "userName": "ADMIN01",
        "name": "Reporte Compras",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "rptRE_app_6_ds",
        "application": 6,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 64810,
        "display_URL": "../Reporte/rptRE_app_6_ds.aspx",
        "display_Menu": "Reporte",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73926,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Proceso",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 6,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 64811,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73927,
        "user_Display_Father": 73926,
        "userName": "ADMIN01",
        "name": "Ingreso a Bodega",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 6,
        "param": 6,
        "orden": 1,
        "consecutivo_Interno": 64812,
        "display_URL": "../Proceso/prcDocumento_3.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 1,
        "des_Tipo_Documento": "Ingreso a Inventario"
      },
      {
        "user_Display": 73928,
        "user_Display_Father": 73926,
        "userName": "ADMIN01",
        "name": "Orden de Compra Proveedor",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 6,
        "param": 30,
        "orden": 1,
        "consecutivo_Interno": 64813,
        "display_URL": "../Proceso/prcDocumento_3.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": "prcDocumento_3",
        "language_ID": 1,
        "tipo_Documento": 41,
        "des_Tipo_Documento": "Orden de Compra Proveedor"
      },
      {
        "user_Display": 73929,
        "user_Display_Father": 73926,
        "userName": "ADMIN01",
        "name": "Documento - Verificación",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento_Verificar",
        "application": 6,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 64814,
        "display_URL": "../Proceso/prcDocumento_Verificar_ds.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73930,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Mantenimiento",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 6,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 64815,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73931,
        "user_Display_Father": 73930,
        "userName": "ADMIN01",
        "name": "Proveedor",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 6,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 64816,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73932,
        "user_Display_Father": 73931,
        "userName": "ADMIN01",
        "name": "Proveedor",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "mntCuenta_Pro",
        "application": 6,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 64817,
        "display_URL": "../Mantenimiento/mntCuenta_Pro.aspx",
        "display_Menu": "Mantenimiento,Proveedor",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73933,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Parametro",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 6,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 64818,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73934,
        "user_Display_Father": 73933,
        "userName": "ADMIN01",
        "name": "Configuración Local",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "shrLocalConfig",
        "application": 6,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 64819,
        "display_URL": "../Short/shrConfig_Local.aspx",
        "display_Menu": "Parametro",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73935,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Consulta",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 6,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 64820,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 73936,
        "user_Display_Father": 73935,
        "userName": "ADMIN01",
        "name": "Lista Ordenes de Compra(Prov)",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "App_Menu_Grd",
        "application": 6,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 64821,
        "display_URL": "../Application/App_Menu_Grd.aspx",
        "display_Menu": "Consulta",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 41,
        "des_Tipo_Documento": "Orden de Compra Proveedor"
      },
      {
        "user_Display": 73937,
        "user_Display_Father": 73935,
        "userName": "ADMIN01",
        "name": "Lista Requerimiento Bodega",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "App_Menu_Grd",
        "application": 6,
        "param": 2,
        "orden": 1,
        "consecutivo_Interno": 64822,
        "display_URL": "../Application/App_Menu_Grd.aspx",
        "display_Menu": "Consulta",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 41,
        "des_Tipo_Documento": "Orden de Compra Proveedor"
      }
    ];

    List<DisplayModel> firstDisplays =
        firstMap.map((json) => DisplayModel.fromMap(json)).toList();

    menuData[0].children.addAll(firstDisplays);

    List<Map<String, dynamic>> secondMap = [
      {
        "user_Display": 72946,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Proceso",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 16,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 63619,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 72947,
        "user_Display_Father": 72946,
        "userName": "ADMIN01",
        "name": "Ajuste de Inventario",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 16,
        "param": 13,
        "orden": 1,
        "consecutivo_Interno": 63620,
        "display_URL": "../Proceso/prcDocumento.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 25,
        "des_Tipo_Documento": "Ajuste de Inventario"
      },
      {
        "user_Display": 72948,
        "user_Display_Father": 72946,
        "userName": "ADMIN01",
        "name": "Requerimiento de Traslado",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 16,
        "param": 45,
        "orden": 1,
        "consecutivo_Interno": 63621,
        "display_URL": "../Proceso/prcDocumento.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 84,
        "des_Tipo_Documento": "Requerimiento de Traslado"
      },
      {
        "user_Display": 72949,
        "user_Display_Father": 72946,
        "userName": "ADMIN01",
        "name": "Traslado de Bodega (Entrada)",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 16,
        "param": 10,
        "orden": 1,
        "consecutivo_Interno": 63622,
        "display_URL": "../Proceso/prcDocumento.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 10,
        "des_Tipo_Documento": "Traslado de Bodega (Entrada)"
      },
      {
        "user_Display": 72950,
        "user_Display_Father": 72946,
        "userName": "ADMIN01",
        "name": "Traslado de Bodega (Salida)",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 16,
        "param": 2,
        "orden": 1,
        "consecutivo_Interno": 63623,
        "display_URL": "../Proceso/prcDocumento.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 9,
        "des_Tipo_Documento": "Traslado de Bodega (Salida)"
      },
      {
        "user_Display": 72951,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Mantenimiento",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 16,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 63624,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 72952,
        "user_Display_Father": 72951,
        "userName": "ADMIN01",
        "name": "Inventario",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "mntInventario",
        "application": 16,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 63625,
        "display_URL": "../Mantenimiento/mntInventario.aspx",
        "display_Menu": "Mantenimiento",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 72953,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Reporte",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 16,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 63626,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 72954,
        "user_Display_Father": 72953,
        "userName": "ADMIN01",
        "name": "Resumidos / Detallados",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "rptRE_app_2_3_ds",
        "application": 16,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 63627,
        "display_URL": "../Reporte/rptRE_app_16_ds.aspx",
        "display_Menu": "Reporte",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 72955,
        "user_Display_Father": 72953,
        "userName": "ADMIN01",
        "name": "Clasificacion",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "rptRE_Inv_Clasificacion",
        "application": 16,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 63628,
        "display_URL": "../Reporte/rptRE_Inv_Clasificacion.aspx",
        "display_Menu": "Reporte",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 72956,
        "user_Display_Father": 72953,
        "userName": "ADMIN01",
        "name": "Inventario",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "rptRE_Inv_Inventario",
        "application": 16,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 63629,
        "display_URL": "../Reporte/rptRE_Inv_Inventario.aspx",
        "display_Menu": "Reporte",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 72957,
        "user_Display_Father": 72953,
        "userName": "ADMIN01",
        "name": "Kardex",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "rptRE_Inv_Kardex",
        "application": 16,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 63630,
        "display_URL": "../Reporte/rptRE_Inv_Kardex.aspx",
        "display_Menu": "Reporte",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      }
    ];
    List<DisplayModel> secondDisplays =
        secondMap.map((json) => DisplayModel.fromMap(json)).toList();
    menuData[1].children.addAll(secondDisplays);

    List<Map<String, dynamic>> thirdMap = [
      {
        "user_Display": 74494,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Consulta",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 2,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 65379,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74495,
        "user_Display_Father": 74494,
        "userName": "ADMIN01",
        "name": "Consulta Producto",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "schProducto",
        "application": 2,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 65380,
        "display_URL": "../Search/schProducto_fc_1.aspx",
        "display_Menu": "Consulta",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74496,
        "user_Display_Father": 74494,
        "userName": "ADMIN01",
        "name": "Listado de Cotizaciones",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "App_Menu_Grd",
        "application": 2,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 65381,
        "display_URL": "../Application/App_Menu_Grd.aspx",
        "display_Menu": "Consulta",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74497,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Parametro",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 2,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 65382,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74498,
        "user_Display_Father": 74497,
        "userName": "ADMIN01",
        "name": "Configuración Local",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "shrLocalConfig",
        "application": 2,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 65383,
        "display_URL": "../Short/shrConfig_Local.aspx",
        "display_Menu": "Parametro",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74499,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Mantenimiento",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 2,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 65384,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74500,
        "user_Display_Father": 74499,
        "userName": "ADMIN01",
        "name": "Cuentas",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 2,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 65385,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74501,
        "user_Display_Father": 74500,
        "userName": "ADMIN01",
        "name": "Cliente",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "mntCuenta_Cli",
        "application": 2,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 65386,
        "display_URL": "../Mantenimiento/mntCuenta_Cli.aspx",
        "display_Menu": "Mantenimiento,Cuentas",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74502,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Proceso",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 2,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 65387,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74503,
        "user_Display_Father": 74502,
        "userName": "ADMIN01",
        "name": "Cotizacion a Cliente",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 2,
        "param": 4,
        "orden": 1,
        "consecutivo_Interno": 65388,
        "display_URL": "../Proceso/prcDocumento_3.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 20,
        "des_Tipo_Documento": "Cotización a Cliente"
      },
      {
        "user_Display": 74504,
        "user_Display_Father": 74502,
        "userName": "ADMIN01",
        "name": "Egreso de Inventario",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 2,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 65389,
        "display_URL": "../Proceso/prcDocumento_3.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 2,
        "des_Tipo_Documento": "Egreso de Inventario"
      },
      {
        "user_Display": 74505,
        "user_Display_Father": 74502,
        "userName": "ADMIN01",
        "name": "Facturas",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 2,
        "param": 21,
        "orden": 1,
        "consecutivo_Interno": 65390,
        "display_URL": "../Proceso/prcDocumento_3.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 3,
        "des_Tipo_Documento": "Factura"
      },
      {
        "user_Display": 74506,
        "user_Display_Father": 74502,
        "userName": "ADMIN01",
        "name": "Envio",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "prcDocumento",
        "application": 2,
        "param": 48,
        "orden": 1,
        "consecutivo_Interno": 65391,
        "display_URL": "../Proceso/prcDocumento_3.aspx",
        "display_Menu": "Proceso",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": 99,
        "des_Tipo_Documento": "Envio"
      },
      {
        "user_Display": 74507,
        "user_Display_Father": null,
        "userName": "ADMIN01",
        "name": "Reporte",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": null,
        "application": 2,
        "param": null,
        "orden": 1,
        "consecutivo_Interno": 65392,
        "display_URL": null,
        "display_Menu": null,
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      },
      {
        "user_Display": 74508,
        "user_Display_Father": 74507,
        "userName": "ADMIN01",
        "name": "Resumidos / Detallados",
        "active": true,
        "visible": true,
        "rol": 3,
        "display": "rptRE_app_2_3_ds",
        "application": 2,
        "param": 1,
        "orden": 1,
        "consecutivo_Interno": 65393,
        "display_URL": "../Reporte/rptRE_app_2_3_ds.aspx",
        "display_Menu": "Reporte",
        "display_URL_Alter": null,
        "language_ID": 1,
        "tipo_Documento": null,
        "des_Tipo_Documento": null
      }
    ];
    List<DisplayModel> thirdDisplays =
        thirdMap.map((json) => DisplayModel.fromMap(json)).toList();

    menuData[2].children.addAll(thirdDisplays);

    //Separar displays nodo 1
    for (var item in menuData) {
      //nodo 1 (displays)
      List<MenuModel> padres = [];
      //nodos sin ordenar (displays)
      List<MenuModel> hijos = [];

      //Genrar estructrura de arbol
      for (var display in item.children) {
        //item menu model (Estructura de arbol propia)
        MenuModel itemMenu = MenuModel(
          name: display.name,
          // id: display.consecutivoInterno,
          route: display.displayUrlAlter ?? "notView",
          idChild: display.userDisplay,
          idFather: display.userDisplayFather,
          children: [],
          display: display,
        );

        //Si la propiedad userDisplayFather esta vacia es el primer nodo
        if (display.userDisplayFather == null) {
          padres.add(itemMenu);
        } else {
          hijos.add(itemMenu);
        }
      }

      //agregar items a la lista propia
      menu.add(
        MenuModel(
          display: null,
          name: item.application.description,
          // id: item.application.application,
          route: "",
          children: ordenarNodos(
            padres,
            hijos,
          ), //Funcion recursiva para ordenar nodos infinitos
        ),
      );
    }

    //retornar menu de arbol

    changeMenuActive(
      menu,
      MenuModel(
        display: null,
        name: "Aplicaciones",
        route: '',
        children: menu,
      ),
    );
  }

// Función recursiva para ordenar nodos infinitos, recibe nodos principales y nodos a ordenar
  List<MenuModel> ordenarNodos(List<MenuModel> padres, List<MenuModel> hijos) {
    // Recorrer los nodos principales
    for (var i = 0; i < padres.length; i++) {
      // Item padre de la iteración
      MenuModel padre = padres[i];

      // Recorrer todos los hijos en orden inverso para evitar problemas al eliminar
      for (var j = hijos.length - 1; j >= 0; j--) {
        // Item hijo de la iteración
        MenuModel hijo = hijos[j];

        // Si coinciden (padre > hijo), agregar ese hijo al padre
        if (padre.idChild == hijo.idFather) {
          padre.children.add(hijo); // Agregar hijo al padre
          // Eliminar al hijo que ya se usó para evitar repetirlo
          hijos.removeAt(j);
          // Llamar a la misma función (recursividad) se detiene cuando ya no hay hijos
          ordenarNodos(padre.children, hijos);
        }
      }
    }

    // Retornar nodos ordenados
    return padres;
  }
}
