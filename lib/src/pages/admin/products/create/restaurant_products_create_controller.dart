import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hoteladmin/src/models/category.dart';
import 'package:hoteladmin/src/models/product.dart';
import 'package:hoteladmin/src/models/response_api.dart';
import 'package:hoteladmin/src/models/user.dart';
import 'package:hoteladmin/src/provider/categories_provider.dart';
import 'package:hoteladmin/src/provider/products_provider.dart';
import 'package:hoteladmin/src/utils/my_snackbar.dart';
import 'package:hoteladmin/src/utils/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class RestaurantProductsCreateController {

  BuildContext context;
  Function refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController descriptionController2 = TextEditingController();
  TextEditingController urlappController = TextEditingController();
  TextEditingController urlmapController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  final ProductsProvider _productsProvider = ProductsProvider();

  User user;
  SharedPref sharedPref = SharedPref();

 

  // IMAGENES
  PickedFile pickedFile;
  File imageFile1;
  File imageFile2;
  File imageFile3;

  ProgressDialog _progressDialog;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
    user =User.fromJson(await sharedPref.read('user'));
   
    _productsProvider.init(context, user);
    refresh();
  }

  

  void createProduct() async {
    String name = nameController.text;
    String description = descriptionController.text;
    String description2 = descriptionController2.text;
    String urlapp = urlappController.text;
    String urlmap = urlmapController.text;
    String telefono = telefonoController.text;

    if (name.isEmpty || description.isEmpty || description2.isEmpty|| telefono.isEmpty|| urlapp.isEmpty || urlmap.isEmpty) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }

    if (imageFile1 == null ) {
      MySnackbar.show(context, 'Selecciona las tres imagenes ');
      return;
    }


    Product product = Product(
      name: name,
      description: description,
      descripcion2: description2,
      urlapp: urlapp,
      urlmap: urlmap,
      telefono: telefono,
      
    );

    List<File> images = [];
    images.add(imageFile1);
    

    _progressDialog.show(max: 100, msg: 'Espere un momento');
    Stream stream = await _productsProvider.create(product, images);
    stream.listen((res) {
      _progressDialog.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        resetValues();
        Future.delayed(Duration(seconds: 2), (){
        Navigator.pushReplacementNamed(context, 'hotel/lista');
      });
      }
    });
  refresh();
    print('Formulario producto, ${product.toJson()}');
  }

  void resetValues() {
    nameController.text = '';
    descriptionController.text = '';
    descriptionController2.text = '';
    urlappController.text = '';
    urlmapController.text = '';
    telefonoController.text = '';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
  
    refresh();
  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null) {

      if (numberFile == 1) {
        imageFile1 = File(pickedFile.path);
      }
      else if (numberFile == 2) {
        imageFile2 = File(pickedFile.path);
      }
      else if (numberFile == 3) {
        imageFile3 = File(pickedFile.path);
      }
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int numberFile) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery, numberFile);
        },
        child: const Text('GALERIA')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera, numberFile);
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


}