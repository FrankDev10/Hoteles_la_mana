import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoteladmin/src/pages/login/login_page.dart';
import 'package:lottie/lottie.dart';

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (ctx)=>LoginPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: buildBoxDecorationFondoPantalla(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           // _ImagenAnimada(),
            tarjeta(),
            /* Spacer(),
             boto() */
          ],
        ),
      ),
      
    );
  }


Widget tarjeta(){
return ZoomIn(
  child:   Container(
  
    width: double.infinity,
  
    height: 350,
  
    margin: EdgeInsets.symmetric(horizontal: 25),
  
    decoration: buildBoxDecorationTarjeta(),
  
    child: Column(
  
      mainAxisAlignment: MainAxisAlignment.center,
  
      children: [
  
        SizedBox(height: 10,),
  
        Container(
  
          
  
          child: Text('HOTELES',style: GoogleFonts.acme(
  
                     fontWeight:FontWeight.bold,
  
                     fontSize: 50, color: Colors.black),),
  
        ),
  
                   Container(
  
                     margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
  
                     child: Text('LA MANÁ',
  
                     style: GoogleFonts.acme(
  
                     fontWeight:FontWeight.bold,
  
                     fontSize: 50, color: Colors.black),
  
                     textAlign: TextAlign.justify,
  
                     ),
  
                   ),
  
  
  
         
  
      ],
  
    ),
  
  ),
);
}


 Widget _ImagenAnimada() {
    return Column(
      children: [
         Container(
           margin: EdgeInsets.only(
            
              top: MediaQuery.of(context).size.height * 0.10),
              
           child: Column(
             //crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('Hoteles en!',style: GoogleFonts.acme(
                 fontWeight:FontWeight.bold,
                 fontSize: 26, color: Colors.white),),
               Text('La Maná',style: GoogleFonts.acme(
                 fontWeight:FontWeight.bold,
                 fontSize: 26, color: Colors.white),),
             ],
           )
           ),
       /*  Container(
          margin: EdgeInsets.symmetric(vertical: 25),
          child: Lottie.asset('assets/json/telefono.json',
              height: 250, width: 250, fit: BoxFit.fill),
        ), */
      ],
    );
  }

  Widget boto(){
 return Container(

     margin:const  EdgeInsets.symmetric(horizontal: 40, vertical: 10),
    height: 50,
    width: double.infinity,
    child: FlatButton(
      onPressed:(){
        irLogin();
      },
      padding: EdgeInsets.all(0),
      child: Ink(
        decoration: buildBoxDecorationBoton(),
        child: Container(
          
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxWidth: double.infinity, minHeight: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Siguiente',
                style:GoogleFonts.acme(color:Colors.white,fontSize: 22)),
                SizedBox(width: 1,),
                Icon(Icons.arrow_forward_ios,color: Colors.white,)
              ],
            ), 
          
          ),
      ),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
    ),
  );
}


BoxDecoration buildBoxDecorationTarjeta() =>  BoxDecoration(
  
    borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Colors.green,
         Colors.white,
         Colors.yellow[300],
         Colors.green[800],
         /* Colors.deepPurple[800].withOpacity(0.6),
         Colors.white.withOpacity(0.4), */
        
        
      ],),
  );


 BoxDecoration buildBoxDecorationFondoPantalla() =>  BoxDecoration(
    //borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            
            
         /* Colors.deepPurple[800],
         Colors.deepPurple[400], */
         Colors.green,
         Colors.white,
         Colors.yellow[300],
         Colors.green[800],
        
        
      ],),
  );

  BoxDecoration buildBoxDecorationBoton() =>  BoxDecoration(
    borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.bottomCenter,
          colors: [
         Colors.green[800],
         Colors.yellow[800],
         
        
      ],),
  );

void irLogin(){
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }
}