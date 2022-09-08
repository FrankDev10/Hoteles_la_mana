import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hoteladmin/src/models/product.dart';
import 'package:hoteladmin/src/models/response_api.dart';
import 'package:hoteladmin/src/models/user.dart';
import 'package:hoteladmin/src/provider/products_provider.dart';
import 'package:hoteladmin/src/provider/users_provider.dart';
import 'package:hoteladmin/src/utils/my_snackbar.dart';
import 'package:hoteladmin/src/utils/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';




class ActualizarProductoController {

  BuildContext context;
  


  final ProductsProvider _productsProvider = ProductsProvider();
  

  PickedFile pickedFile;
  PickedFile pickedFile2;
  

   
  File imageFile1;
  File imageFile2;
  File imageFile3;

  
  Function refresh;

  ProgressDialog _progressDialog;

  bool isEnable = true;
  User user;
  Product product;
  final SharedPref _sharedPref = SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
   // _productsProvider.init(context, user);

   // _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    
   
    refresh();
  }


    
    Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null) {
      imageFile1 = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }
  

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery,);
          //selectImage2(ImageSource.gallery);
        },
        child: const Text('GALERIA')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera,);
          //selectImage2(ImageSource.camera);
        },
        child: const Text('CÁMARA')
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }



  void back() {
    Navigator.pop(context);
  }
}