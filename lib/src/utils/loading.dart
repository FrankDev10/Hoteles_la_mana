import 'package:flutter/material.dart';

void loading(BuildContext context) {
showDialog(
  barrierDismissible: false,
      context: context, 
      builder: (context){
        return Center(child: Container(
          margin: EdgeInsets.all(10),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.8)
          ),
          child: Container(
         
            
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 CircularProgressIndicator(),
           
            //Text(text,style: TextStyle(fontSize: 14,color: Colors.black),)
              ],
            ))));
      });
}
