import 'dart:convert';

import 'package:flutter/services.dart';

import '../entities/food.dart';

class MenuDataProvider{

  Future<List<Food>>selectFood(int selectedCategory) async{
    ///Читает еду из JSON
      final String response = await rootBundle.loadString('assets/json/food.json');
      final data = json.decode(response) as List<dynamic>;
      var dataList = data.map((e) => Food.fromJson(e)).toList();
      List<Food> foodList = [];
      for(int i = 0; i<dataList.length; i++){
        var food = dataList[i];
        if(food.foodType == selectedCategory){
          foodList.add(food);
        }
      }
      return foodList;
  }
}