import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hoteladmin/src/models/response_api.dart';
import 'package:hoteladmin/src/models/user.dart';
import 'package:hoteladmin/src/provider/users_provider.dart';
import 'package:hoteladmin/src/utils/my_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterControler {
  BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;

  bool isEnable = true;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
  }

  Future<void> register() async {
     
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastname = lastNameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty ||
        
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    if (confirmPassword != password) {
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

   if (phone.length <=9 ) {
      MySnackbar.show(
          context, 'El telefono icorrecto ingrese 10 Digitos');
      return;
    }
   

    if (password.length < 6) {
      MySnackbar.show(
          context, 'Las contraseñas debe tener al menos 6 caracteres');
      return;
    }

    

    User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        
        password: password);


        ResponseApi  responseApi =await usersProvider.createWithImage(user);
     
   
    if(responseApi.success){
     MySnackbar.show(context, responseApi.message);
    
    Future.delayed(Duration(seconds: 2), (){
        Navigator.pushReplacementNamed(context, 'login');
      });
  
     
    }else{
      MySnackbar.show(context, responseApi.message);
      
     
    }
  
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: const Text('GALERIA'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: const Text('CÁMARA'));

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void back() {
    Navigator.pop(context);
  }
}
