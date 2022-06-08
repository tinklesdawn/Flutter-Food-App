// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      foodType: json['foodType'] as int,
      image: json['image'] as String,
      name: json['name'] as String,
      structure: json['structure'] as String,
      cost: json['cost'] as int,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'image': instance.image,
      'foodType': instance.foodType,
      'name': instance.name,
      'structure': instance.structure,
      'cost': instance.cost,
    };
