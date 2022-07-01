import 'package:flutter/material.dart';
import 'pages/menu_page.dart';

void main() {
  runApp(const FoodApp());
}

class FoodApp extends StatelessWidget{
  const FoodApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const MenuPage(),
        theme: ThemeData(
          fontFamily: 'Ethna',
        ),
      );
  }

}
