import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food{
  late int _foodType;
  late String _image;
  late String _name;
  late String _structure;
  late int _cost;
  Food({
    required int foodType,
    required String image,
    required String name,
    required String structure,
    required int cost
  }){
    _foodType = foodType;
    _image = image;
    _name = name;
    _structure = structure;
    _cost = cost;
  }
  String get image => _image;
  int get foodType => _foodType;
  String get name => _name;
  String get structure => _structure;
  int get cost => _cost;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}