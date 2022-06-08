import 'dart:async';

import 'package:foodapp/domain/data_providers/menu_provider.dart';

import '../entities/food.dart';

class MenuState{
  final int _selectedCategory;
  final List<Food> _food;

  int get selectedCategory => _selectedCategory;
  List<Food> get food => _food;

//<editor-fold desc="Data Methods">

  const MenuState({
    required int selectedCategory,
    required List<Food> food,
  })  : _selectedCategory = selectedCategory,
        _food = food;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuState &&
          runtimeType == other.runtimeType &&
          _selectedCategory == other._selectedCategory &&
          _food == other._food);

  @override
  int get hashCode => _selectedCategory.hashCode ^ _food.hashCode;

  @override
  String toString() {
    return 'MenuState{ _selectedCategory: $_selectedCategory, _food: $_food,}';
  }

  MenuState copyWith({
    int? selectedCategory,
    List<Food>? food,
  }) {
    return MenuState(
      selectedCategory: selectedCategory ?? _selectedCategory,
      food: food ?? _food,
    );
  }

//</editor-fold>
}

class MenuBloc{
  static final MenuBloc bloc = MenuBloc._();

  final provider = MenuDataProvider();
  final _streamController = StreamController<MenuState>.broadcast();
  MenuState _state = const MenuState(
      selectedCategory: 2,
      food: []);

  MenuState get state => _state;
  Stream<MenuState> get controller => _streamController.stream;

  MenuBloc._(){
    _initialize();
  }

  void _updateState(MenuState state){
    _state = state;
    _streamController.add(state);
  }

  Future<void> _initialize() async{
    int startCategory = 0;
    changeCategory(startCategory);
  }

  Future<void> changeCategory(int category) async{
    List<Food> food = await provider.selectFood(category);
    _updateState(_state.copyWith(
        selectedCategory: category,
        food: food,
    ));
  }
}