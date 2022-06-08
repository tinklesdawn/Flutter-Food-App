import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../domain/entities/food.dart';

class Data{

  ///Возвращает еду из выбранной категории
  static Future<List<Food>> readFood(int selectedCategory) async{
    var foodList = await JsonHandler.readJson();
    List<Food> selectedFood = [];
    for(int i = 0; i<foodList.length; i++){
      var food = foodList[i];
      if(food.foodType == selectedCategory){
        selectedFood.add(food);
      }
    }
    return selectedFood;
  }

}

class JsonHandler{

  ///Читает еду из JSON
  static Future<List<Food>> readJson() async {
    final String response = await rootBundle.loadString('assets/json/food.json');
    final data = json.decode(response) as List<dynamic>;
    return data.map((e) => Food.fromJson(e)).toList();
  }

}