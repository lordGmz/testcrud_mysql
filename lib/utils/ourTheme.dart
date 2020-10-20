import 'package:flutter/material.dart';

class OurTheme {
  ThemeData buildTheme(){
    return ThemeData(
      canvasColor: Colors.white,
      primaryColor: Colors.grey[50],
      accentColor: Colors.grey[500],
      secondaryHeaderColor: Colors.grey[600],
      hintColor: Colors.grey[500],
      //theme des textFields
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color:Colors.grey,
          ),
        ),
      ),


      //theme des bouttons
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          minWidth:40.0 , //largeur minimale
          height: 50.0, //hauteur
          //Arrondissement des bords des bouttons
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          )
      ),

    );
  }
}