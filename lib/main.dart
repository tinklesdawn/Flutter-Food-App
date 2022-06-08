import 'package:flutter/material.dart';

import 'models/data_provider.dart';
import 'pages/menu_page.dart';

void main() {
  runApp(FoodApp());
}

class FoodApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuPage(),
      theme: ThemeData(
        fontFamily: 'Ethna',
      ),
    );
  }

}
