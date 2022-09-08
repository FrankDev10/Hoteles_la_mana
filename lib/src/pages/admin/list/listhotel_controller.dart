import 'package:flutter/material.dart';
import 'package:hoteladmin/src/models/address.dart';
import 'package:hoteladmin/src/models/order.dart';
import 'package:hoteladmin/src/models/product.dart';
import 'package:hoteladmin/src/models/user.dart';
import 'package:hoteladmin/src/pages/admin/products/actualizar/actualizar_products_create_page.dart';

import 'package:hoteladmin/src/provider/orders_provider.dart';
import 'package:hoteladmin/src/provider/products_provider.dart';
import 'package:hoteladmin/src/utils/my_snackbar.dart';
import 'package:hoteladmin/src/utils/shared_pref.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ListHotelController {

  BuildContext context;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function refresh;
  User user;
  Address address;

 
  final ProductsProvider _productsProvider = ProductsProvider();

  
List<Product> listHOTEL = [];
  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    //this.address = address;
    user = User.fromJson(await _sharedPref.read('user'));
    //this.address = address;
    _productsProvider.init(context, user);
     listarHOTEL();
    refresh();
  }


 void listarHOTEL() async{
    listHOTEL = await _productsProvider.ListahOTEL();
    refresh();
  }

  void deleteItem(String id)async{
    await _productsProvider.eliminarHotel(id);
   MySnackbar.show(
          context, 'Hotel eliminado');
           listarHOTEL();
      refresh();
   
  }

  void editar(Product id) {
   
     showBarModalBottomSheet(
      
        duration: Duration(milliseconds: 350),
        context: context,
        builder: (context) => ActualizarProducto(id: id)
    ); 
  } 
  /* Future<List<Order>> getOrders(String status) async {
    //print('PRUEBA: ${getOrders(status).toString()}');
    return await _ordersProvider.getByStatus(status);

  } */

  /* void openBottomSheet(Order order ) async {
    isUpdate = await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => RestaurantOrdersDetailPage(order: order)
    );

      refresh();
   /*  if(isUpdate) {
    } */
  } */


  void logout() {
    _sharedPref.logout(context);
  }

  void goToCategoryCreate() {
    Navigator.pushNamed(context, 'restaurant/categories/list');
  }

  void goToProductCreate() {
    Navigator.pushNamed(context, 'crear/hotel');
  }
  void irPdf() {
    Navigator.pushNamed(context, 'irapdf');
  }
  void listaHabitacion() {
    Navigator.pushNamed(context, 'listaHabitacion');
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

}