import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hoteladmin/src/models/product.dart';
import 'package:hoteladmin/src/models/response_api.dart';
import 'package:hoteladmin/src/models/user.dart';
import 'package:hoteladmin/src/pages/admin/products/actualizar/actualizar_product_controller.dart';

import 'package:hoteladmin/src/provider/products_provider.dart';
import 'package:hoteladmin/src/utils/my_colors.dart';
import 'package:hoteladmin/src/utils/my_snackbar.dart';
import 'package:hoteladmin/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';



import '../../../../models/category.dart';

class ActualizarProducto extends StatefulWidget {
  Product id;
  //Product produc;
   ActualizarProducto({Key key,  this.id}) : super(key: key);

  @override
  State<ActualizarProducto> createState() => _ActualizarProductoState();
}

class _ActualizarProductoState extends State<ActualizarProducto> {

  final ActualizarProductoController _con = ActualizarProductoController();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController descriptionController2 = TextEditingController();
  TextEditingController urlappController = TextEditingController();
  TextEditingController urlmapController = TextEditingController();
   TextEditingController telefonoController = TextEditingController();

  final ProductsProvider _productsProvider = ProductsProvider();
  User user;
  ProgressDialog _progressDialog;
  final SharedPref _sharedPref = SharedPref();
  bool isEnable = true;


 
   


 
  File imageFile2;
  File imageFile3;

  Product product;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.id.name;
    descriptionController.text = widget.id.description;
    descriptionController2.text =widget.id.descripcion2;
    urlappController.text = widget.id.urlapp;
    urlmapController.text = widget.id.urlmap;
    telefonoController.text = widget.id.telefono;

     _progressDialog = ProgressDialog(context: context);
  _productsProvider.init(context, user);
   // user = User.fromJson(await _sharedPref.read('user'));
    



    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Hotel'),
      ),
      body: ListView( // EL LISTVIEW ES PARA HACER SCROOLL EN DIMENSIONES MAS PEQUENAS DE CELULARES
        children:[
          const SizedBox(height: 30),
          _textFieldName(),
          _textFieldDescription(),
          _textFieldDescription2(),
          _textFielURLapp(),
          _textFielURLmap(),
          telefono(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            child: Text('Subir Imagen del hotel'),
          ),
          Container(
           
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _cardImage(),
          ),
         // _dropDownCategories(_con.categories),
        ],
      ),
      bottomNavigationBar:  _buttonCreate(),
    );
  }


/* Widget _cardImage(File imageFile, int numberFile) {
    return GestureDetector(
      onTap: () {
       // _con.showAlertDialog(numberFile);
      },
      child: 
       Card(
        elevation: 3.0,
        child: SizedBox(
          height: 140,
            width: MediaQuery.of(context).size.width * 0.26,
          child: CircleAvatar(
        backgroundImage: imageFile != null
            ? FileImage(_con.imageFile1)
            : widget.id?.image1 != null
              ? NetworkImage(widget.id?.image1)
              : const AssetImage('assets/img/user_profile_2.png'),
        radius: 30,
        backgroundColor: Colors.grey[200],
      ),
        ),
      )
      
    );
  }
 */

    void update() async {
    String name = nameController.text.trim();
    String description = descriptionController.text.trim();
    String descripcion2 = descriptionController2.text.trim();
    String urlapp = urlappController.text.trim();
    String urlmap = urlmapController.text.trim();
    String telefono = telefonoController.text.trim();

    if(name.isEmpty || description.isEmpty || descripcion2.isEmpty || telefono.isEmpty || urlapp.isEmpty || urlmap.isEmpty ){
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return ;
    }

    _progressDialog.show(max: 100, msg: 'Espere un momento..');
    isEnable = false;

    Product myUser = Product(
        id: widget.id.id,
        name: name,
        description: description,
        descripcion2: descripcion2,
        urlapp: urlapp,
        urlmap: urlmap,
        telefono: telefono,
         image1: widget.id.image1,
       
    );




    Stream stream = await _productsProvider.updateProduct(myUser, _con.imageFile1);
    stream.listen((res) async {

      _progressDialog.close();

      //ResponseApi responseApi = await usersProvider.list(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message);

      if (responseApi.success) {
       // user = await usersProvider.getById(myUser.id); // OBTENIENDO USARIOS DE LA BD
       // print('Usuario obtenido: ${user.toJson()}');
        //_sharedPref.save('user', user.toJson());
        Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, 'hotel/lista', (route) => false);
        });
      }
      else {
        isEnable = true;
      }
    });
  }

 



  Widget _textFieldName() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: nameController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Nombre del Hotel',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primarycolorDark
            ),
            suffixIcon: Icon(
              Icons.local_hotel_rounded,
              color: MyColors.primarycolor,)
        ),
      ),
    );

  }
  Widget telefono() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: telefonoController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Ingrese el telefono',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primarycolorDark
            ),
            suffixIcon: Icon(
              Icons.local_hotel_rounded,
              color: MyColors.primarycolor,)
        ),
      ),
    );

  }
  

  Widget _textFielURLapp() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: urlappController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Ingrese url de la App',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primarycolorDark
            ),
            suffixIcon: Icon(
              Icons.local_hotel_rounded,
              color: MyColors.primarycolor,)
        ),
      ),
    );

  }

  Widget _textFielURLmap() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: urlmapController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Ingrese url de la App',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primarycolorDark
            ),
            suffixIcon: Icon(
              Icons.local_hotel_rounded,
              color: MyColors.primarycolor,)
        ),
      ),
    );

  }



  Widget _textFieldDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: descriptionController,
        maxLines: 8,
        maxLength: 10000,
        decoration: InputDecoration(
          hintText: 'Descripción del Hotel',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: MyColors.primarycolorDark
          ),
          suffixIcon: Icon(
            Icons.description,
            color: MyColors.primarycolor,
          ),
        ),
      ),
    );
  }
   Widget _textFieldDescription2() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: descriptionController2,
        maxLines: 8,
        maxLength: 10000,
        decoration: InputDecoration(
          hintText: 'Descripción de ir a la app',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: TextStyle(
              color: MyColors.primarycolorDark
          ),
          suffixIcon: Icon(
            Icons.description,
            color: MyColors.primarycolor,
          ),
        ),
      ),
    );
  }





  Widget _cardImage() {
    return GestureDetector(
      onTap: () {
       _con.showAlertDialog();
      },
     
     child: 
     Container(
          width: 200,
          height:200,
         decoration: BoxDecoration(
            image: DecorationImage(
              image: _con.imageFile1 != null
              ?FileImage(_con.imageFile1)
              : widget.id?.image1 != null
              ? NetworkImage(widget.id?.image1)
              : const AssetImage('assets/img/user_profile_2.png'),
      

            
            fit: BoxFit.cover)
          ),
        ),
    
     
     
    );
  }
  

  
  Widget _buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: update,
        child: const Text('Actualizar Hotel',style: TextStyle(fontSize: 20),),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primarycolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: const EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  void refresh() {
    setState(() {
    });
  }
}
