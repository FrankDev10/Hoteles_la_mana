import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hoteladmin/src/pages/admin/products/create/restaurant_products_create_controller.dart';
import 'package:hoteladmin/src/utils/my_colors.dart';



import '../../../../models/category.dart';

class RestaurantProductsCreatePage extends StatefulWidget {
  const RestaurantProductsCreatePage({Key key}) : super(key: key);

  @override
  State<RestaurantProductsCreatePage> createState() => _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState extends State<RestaurantProductsCreatePage> {

  final RestaurantProductsCreateController _con = RestaurantProductsCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(_con.imageFile1, 1),
               /*  _cardImage(_con.imageFile2, 2),
                _cardImage(_con.imageFile3, 3), */
              ],
            ),
          ),
         // _dropDownCategories(_con.categories),
        ],
      ),
      bottomNavigationBar:  _buttonCreate(),
    );
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
        controller: _con.nameController,
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
  
  Widget _textFielURLapp() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.urlappController,
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

  }Widget _textFielURLmap() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.urlmapController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Ingrese url del mapa',
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
        controller: _con.descriptionController,
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
        controller: _con.descriptionController2,
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

    Widget telefono() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.telefonoController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'Ingrese el Telefono',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primarycolorDark
            ),
            suffixIcon: Icon(
              Icons.phone,
              color: MyColors.primarycolor,)
        ),
      ),
    );

  
  }

  Widget _cardImage(File imageFile, int numberFile) {
    return GestureDetector(
      onTap: () {
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null
      ? Card(
        elevation: 3.0,
        child: SizedBox(
          height: 140,
            width: MediaQuery.of(context).size.width * 0.26,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
      )
      : Card(
        elevation: 3.0,
        child: SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width * 0.26,
          child: const Image(
              image: AssetImage('assets/img/no-image.png'),
          ),
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
        onPressed: _con.createProduct,
        child: const Text('Crear Hotel',style: TextStyle(fontSize: 20),),
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
