import 'package:flutter/material.dart';

class Themeing extends StatelessWidget {

  final Widget _homePage;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Themeing(this._homePage);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      home: _homePage,
      theme: ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
        ),
        titleMedium: TextStyle(
          color: Color.fromARGB(255, 10, 10, 10),
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
        ),
        titleSmall: TextStyle(
          color: Colors.blueGrey,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      primarySwatch: Colors.deepPurple,
      cardTheme: const CardTheme(
        color: Color.fromARGB(255, 181, 181, 179),
        shadowColor: Color.fromARGB(255, 56, 41, 131),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Colors.blueGrey,
              style: BorderStyle.solid),
        ),
      ),
    )
    );;
  }
}
