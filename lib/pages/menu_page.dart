import 'package:flutter/material.dart';
import 'package:foodapp/domain/blocs/menu_bloc.dart';
import 'package:foodapp/pages/product_description_page.dart';
import '../constants.dart';
import 'package:foodapp/domain/entities/food.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuPage extends StatelessWidget{
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MenuBloc(),
    child: Scaffold(
      appBar: foodAppBar(),
      body: SizedBox(
        child: Expanded(
          child: Container(
            color: ConstColors.backgroundWhite,
            child: Column(
              children: const [
                FoodTabBar(),
                MenuWidget(),
              ],
            ),
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
  const FoodTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MenuBloc>(context);
          return BlocBuilder<MenuBloc, MenuState>(
            builder: (BuildContext context, state) {
              return Container(
              color: ConstColors.backgroundWhite,
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: buttons(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 7, 0, 15),
                      child: Text(
                        _activeButton(bloc)._text,
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
          );
  }

  TabButton _activeButton(MenuBloc bloc){
    var button = buttons();
    for(int i = 0; i< button.length; i++){
      if(button[i]._isActive(bloc.selectedCategory)){
        return button[i];
      }
    }
    throw Exception("No one bar is active!");
  }

  List<TabButton> buttons() {
    List<TabButton> buttonS =
      [
        TabButton("Пицца", 0),
        TabButton("Бургер", 1),
        TabButton("Закуски", 2),
        TabButton("Десерты", 3),
      ];
    return buttonS;
  }

}

///Кнопка в таббаре
class TabButton extends StatelessWidget {
  final String _text;
  final int _categoryNumber;

  get categoryNumber => _categoryNumber;

  const TabButton(this._text, this._categoryNumber, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuBloc bloc = BlocProvider.of<MenuBloc>(context);
    return Expanded(
      child: Container(
        decoration: _boxStyle(bloc),
        child: TextButton(
          style: TextButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          onPressed: () {
            bloc.add(ChangeCategory(_categoryNumber));
          },
          child: Text(
            _text,
            style: _textStyle(bloc.selectedCategory),
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle(int selectedCategory) {
    if (_categoryNumber != selectedCategory) {
      return const TextStyle(
          color: ConstColors.unselectedTabText,
          fontSize: 15
      );
    } else {
      return const TextStyle(
        color: ConstColors.textOrange,
        fontSize: 15,
      );
    }
  }

  BoxDecoration _boxStyle(MenuBloc bloc) {
    if (_categoryNumber == bloc.selectedCategory) {
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

  bool _isActive(int selectedCategory) {
    return (_categoryNumber == selectedCategory);
  }

}
///Страница с меню
class MenuWidget extends StatelessWidget{
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MenuBloc>(context);
    return BlocBuilder<MenuBloc, MenuState>(
        builder: (BuildContext context, state) {
        return Expanded(
            child: Container(
                color: ConstColors.backgroundWhite,
                child: SingleChildScrollView(
                        child: Column(
                          children: _createFoodWidgets(bloc),
                        ),
                      )
          )

      );
        }
      );
  }


  ///Создает лист из FoodWidget
  List<FoodWidget> _createFoodWidgets(MenuBloc bloc){
    bloc.add(UpdateData());
    List<FoodWidget> foodWidgets = [];
    for(int i=0; i<bloc.food.length; i++){
      foodWidgets.add(FoodWidget(foodObject: bloc.food[i]));
    }
    return foodWidgets;
  }

}

///Виджет с картинкой товара, ценой, наименованием и описанием
class FoodWidget extends StatelessWidget{
  final Food foodObject;

  const FoodWidget({super.key, required this.foodObject});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: TextButton(
        onPressed: (){
          Route route = MaterialPageRoute(builder: (context) => ProductDescription(food: foodObject));
          Navigator.push(context, route);
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
        ),
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
                    image: AssetImage(foodObject.image),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodObject.name,
                          style: const TextStyle(color: ConstColors.textDark, fontSize:  17),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          ),
                        Expanded(
                          child: Text(
                            foodObject.structure,
                            style: const TextStyle(color: ConstColors.unselectedTabText, fontSize: 15),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    //color: Color.fromARGB(54, 255, 0, 0),
                    width: double.maxFinite,
                    //height: 40,
                    child: Text(
                      foodObject.cost.toString(),
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
    );
  }
}

