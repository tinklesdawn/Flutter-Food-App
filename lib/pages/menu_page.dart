import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodapp/domain/blocs/menu_bloc.dart';
import '../constants.dart';
import 'package:foodapp/domain/entities/food.dart';
import 'product_description_page.dart';

final bloc = MenuBloc.bloc;


class MenuPage extends StatelessWidget{
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: foodAppBar(),
      body: SizedBox(
        child: Expanded(
          child: Container(
            color: ConstColors.backgroundWhite,
            child: Column(
              children: [
                FoodTabBar(),
                Menu(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
///AppBar
AppBar foodAppBar(){
    return AppBar(
      backgroundColor: ConstColors.backgroundWhite,
      elevation: 0,
      title: Container(
        padding: const EdgeInsets.fromLTRB(2,0,0,0),
        child: const Text(
          "Меню",
          style: TextStyle(
            fontSize: 26,
            color: ConstColors.textOrange,
          ),
        ),
      ),
    );
}

///TabBar
class FoodTabBar extends StatelessWidget{
  FoodTabBar({Key? key}) : super(key: key);

  List<TabButton> buttons = const[
    TabButton("Пицца", 0),
    TabButton("Бургер", 1),
    TabButton("Закуски", 2),
    TabButton("Десерты", 3),
  ];

  @override
  Widget build(BuildContext context) {

    return Container(
      child: StreamBuilder(
        stream: bloc.controller,
        builder: (context, data){
          return Container(
            color: ConstColors.backgroundWhite,
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: buttons,
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 7, 0, 15),
                    child: Text(
                      _activeButton()._text,
                      style: const TextStyle(
                        fontSize: 15,
                        color: ConstColors.unselectedTabText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TabButton _activeButton(){
    for(int i = 0; i< buttons.length; i++){
      if(buttons[i]._isActive()){
        return buttons[i];
      }
    }
    throw Exception("No one bar is active!");
  }
}

///Кнопка в таббаре
class TabButton extends StatelessWidget {
  final String _text;
  final int _categoryNumber;

  final TextStyle styleUnselected = const TextStyle(
      color: ConstColors.unselectedTabText,
      fontSize: 15
  );
  final TextStyle styleSelected = const TextStyle(
    color: ConstColors.textOrange,
    fontSize: 15,
  );

  get categoryNumber => _categoryNumber;

  const TabButton(this._text, this._categoryNumber, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MenuState>(
        stream: bloc.controller,
        initialData: bloc.state,
        builder: (context, data) {
          return Expanded(
            child: Container(
              decoration: _boxStyle(),
              child: TextButton(
                style: TextButton.styleFrom(
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  bloc.changeCategory(categoryNumber);
                },
                child: Text(
                  _text,
                  style: _textStyle(),
                ),
              ),
            ),
          );
        }
    );
  }

  TextStyle _textStyle() {
    if (_categoryNumber == bloc.state.selectedCategory) {
      return styleSelected;
    } else {
      return styleUnselected;
    }
  }

  BoxDecoration _boxStyle() {
    if (_isActive()) {
      return const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                width: 2,
                color: ConstColors.textOrange,
              )
          )
      );
    } else{
      return const BoxDecoration();
    }
  }

  bool _isActive() {
    return (_categoryNumber == bloc.state.selectedCategory);
  }

}
///Страница с меню
class Menu extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Expanded(
              child: Container(
                color: ConstColors.backgroundWhite,
                child: StreamBuilder<MenuState>(
                  initialData: bloc.state,
                  stream: bloc.controller,
                  builder: (context, data){
                    if(data.hasData){
                      return SingleChildScrollView(
                        child: Column(
                          children: _createFoodWidgets(),
                        ),
                      );
                    } else if(data.hasError){
                      return Center(
                        child: Text(
                          "Error: ${data.error}",
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                            "Empty"
                          ),
                        );
                      }
                    },
                ),
              ),
    );
  }

  ///Создает лист из FoodWidget
  List<FoodWidget> _createFoodWidgets(){
    List<FoodWidget> foodWidgets = [];
    for(int i=0; i<bloc.state.food.length; i++){
      foodWidgets.add(FoodWidget(bloc.state.food[i]));
    }
    return foodWidgets;
  }

}

///Виджет с картинкой товара, ценой, наименованием и описанием
class FoodWidget extends StatelessWidget{
  late Food _foodObject;

  FoodWidget(Food food){
    _foodObject = food;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: TextButton(
        onPressed: (){
          Route route = MaterialPageRoute(builder: (context) => ProductDescription(_foodObject));
          Navigator.push(context, route);
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
        ),
        child: Container(
          child: Row(
          children: [

            //Скругленное изображение товара
            Container(
              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: AspectRatio(
                  aspectRatio: 1/1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      fit: BoxFit.cover,
                      image: _foodObject.getImage(),
                    ),
                  ),
                ),
              ),

            //Описание, название, стоимость
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        //flex: 4,
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _foodObject.name,
                              style: const TextStyle(color: ConstColors.textDark, fontSize:  17),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              ),
                            Expanded(
                              child: Text(
                                _foodObject.structure,
                                style: const TextStyle(color: ConstColors.unselectedTabText, fontSize: 15),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //color: Color.fromARGB(54, 255, 0, 0),
                      width: double.maxFinite,
                      //height: 40,
                      child: Text(
                        _foodObject.cost.toString(),
                        style: const TextStyle(color: ConstColors.textOrange, fontSize: 22),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
          ),
        ),
     ),
    );
  }
}

