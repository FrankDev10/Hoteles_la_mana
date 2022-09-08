import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hoteladmin/src/models/category.dart';
import 'package:hoteladmin/src/models/product.dart';
import 'package:hoteladmin/src/models/user.dart';
import 'package:hoteladmin/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:hoteladmin/src/provider/categories_provider.dart';
import 'package:hoteladmin/src/provider/products_provider.dart';
import 'package:hoteladmin/src/utils/loading.dart';
import 'package:hoteladmin/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ClientProductsListController {

  BuildContext context;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function refresh;
  User user;
  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  final ProductsProvider _productsProvider = ProductsProvider();
  
List<Product> listHOTEL = [];
  Timer searchOnStoppedTyping;
  String productName = '';

  Future init(BuildContext context, Function refresh) async{
    loading(context);
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    
    _productsProvider.init(context, user);
     listarHOTEL();
    refresh();
  }

  

 void listarHOTEL() async{
    listHOTEL = await _productsProvider.ListahOTEL();
    refresh();
    Navigator.of(context).pop();
  }

 void detalle(Product product) {
   
     showBarModalBottomSheet(
      
        duration: Duration(milliseconds: 350),
        context: context,
        builder: (context) => ClientsProductsDetailPage(producto: product)
    ); 
  }

 

  /* void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientsProductsDetailPage(product: product,)
    );
  } */

  void logout() {
    _sharedPref.logout(context);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }

  void goToOrderCreatePage() {
    Navigator.pushNamed(context, 'client/orders/list');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

}