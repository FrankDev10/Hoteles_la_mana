import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hoteladmin/src/models/product.dart';
import 'package:hoteladmin/src/models/user.dart';
import 'package:hoteladmin/src/provider/products_provider.dart';
import 'package:hoteladmin/src/utils/shared_pref.dart';



class ProductsDetailController {

  BuildContext context;
  Function refresh;

  Product product;

   User user;

  final SharedPref _sharedPref = SharedPref();
  ProductsProvider productsProvider = new ProductsProvider();


  Future init(BuildContext context, Function refresh, Product product) async {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
   
    
    user = User.fromJson(await _sharedPref.read('user'));
    productsProvider.init(context, user);


    refresh();
  }

  

} 