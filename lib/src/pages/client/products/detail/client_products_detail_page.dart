

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoteladmin/src/models/product.dart';
import 'package:hoteladmin/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:hoteladmin/src/utils/my_colors.dart';

import 'package:url_launcher/url_launcher.dart';


class ClientsProductsDetailPage extends StatefulWidget {

  Product producto;

  ClientsProductsDetailPage({Key key, @required this.producto}) : super(key: key);

  @override
  State<ClientsProductsDetailPage> createState() => _ClientsProductsDetailPageState();
}

class _ClientsProductsDetailPageState extends State<ClientsProductsDetailPage> {

  final ProductsDetailController _con = ProductsDetailController();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.producto);
    });
  } 

  final Uri _url = Uri.parse('https://flutter.dev');
  @override
  Widget build(BuildContext context) {
    return Container(
       height: MediaQuery.of(context).size.height * 0.95,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(' ff${_con?.product?.name ?? ''}'),
            _imageSlideshow(),
            SizedBox(height: 22,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,),
              child: Text('${_con?.product?.name ?? ''}',
                   style: GoogleFonts.acme(fontSize: 28, color: Colors.black),),
            ),
             
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
             child: Row(
               children: [
                 Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],)
               ],
             ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,),
              child: Text('${_con?.product?.description ?? ''}',
                   style: GoogleFonts.abel(
                     
                     fontSize: 20, color: Colors.black),
                     textAlign: TextAlign.justify,
                     ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,),
              child: Text('${_con.product?.descripcion2}',
                   style: GoogleFonts.abel(
                     
                     fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
                     textAlign: TextAlign.justify,
                     ),
            ),
            _buttonApp(),
            _buttonMap()
           
           // _textName(),
           // _textDescription(),
           // const Spacer(),
           // _addOrRemoveItem(),
           // _standarDelivery(),
           // _buttonShoppingBag()
          ],
        ),
      ),
    );
  }




openUrlApp() async{
  
  var URL_android ="${_con.product.urlapp}";
  var URL_ios ="${_con.product.urlapp}";

  if(Platform.isIOS){
    if(await canLaunch(URL_ios)){
      await launch(URL_ios);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: new Text("No hay tienda para la descarga..."),));
    }
  }else{
    if(await canLaunch(URL_android)){
      await launch(URL_android);
    }else{
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: new Text("No hay tienda para la descarga.."),));
    }
  }
}

openUrlMap() async{

  var URL_android ="${_con.product.urlmap}";
  var URL_ios ="${_con.product.urlmap}";

  if(Platform.isIOS){
    if(await canLaunch(URL_ios)){
      await launch(URL_ios);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: new Text("HOLA JAJA NO VALE LA HUEVADA"),));
    }
  }else{
    if(await canLaunch(URL_android)){
      await launch(URL_android);
    }else{
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: new Text("NO VALE TU HUEVADA JAJA"),));
    }
  }
}

 Widget _buttonApp() {
   
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
          onPressed: (){
            if(_con.product.urlapp == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: new Text("No existe tienda disponible"),));
            }else{
              // launch('${_con?.product?.urlmap ??  ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: new Text("NO VALE TU HUEVADA JAJA"),))}');
              launch('${_con?.product?.urlapp ?? ""}');}
            //openUrlMap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Descargar App',style: TextStyle(fontSize: 20),),
              Icon(Icons.mobile_friendly,size: 23,)
            ],
          ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

 Widget _buttonMap() {

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
          onPressed: (){
            if(_con.product.urlmap == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: new Text("No existe dirección disponible"),));
            }else{
            // launch('${_con?.product?.urlmap ??  ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: new Text("NO VALE TU HUEVADA JAJA"),))}');
           launch('${_con?.product?.urlmap ?? ""}');}
            //openUrlMap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Dirección',style: TextStyle(fontSize: 20),),
              Icon(Icons.map,size: 23,)
            ],
          ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }


  Widget _imageSlideshow() {
    return Stack(
      children: [
        ImageSlideshow(
          width: double.infinity, 
         
          height: MediaQuery.of(context).size.height * 0.4 ,
     
          initialPage: 0,
          indicatorColor: MyColors.primarycolor,
          indicatorBackgroundColor: Colors.grey,
          children: [
            FadeInImage(
              image: _con.product?.image1 != null
                  ? NetworkImage(_con.product.image1)
                  : const AssetImage('assets/img/pizza2.png'),
              fit: BoxFit.cover, // o tambien puede ser fill, pero mejor cover
              fadeInDuration: const Duration(milliseconds: 50),
              placeholder: const AssetImage('assets/img/no-image.png'),
            ),
          ],
          onPageChanged: (value) {
            print('Page changed: $value');
          },
          autoPlayInterval: 10000,
            isLoop: false,
        ),
        
      ],
    );
  }

  void refresh() {
    setState(() {
  });} 
}


 