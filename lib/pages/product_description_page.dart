import 'package:flutter/material.dart';
import 'package:foodapp/constants.dart';
import 'package:foodapp/domain/entities/food.dart';

///Страница с подробным описанием товара
class ProductDescription extends StatelessWidget{
  late Food _food;

  ProductDescription(Food food){
    _food = food;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Comfortaa'
      ),
      home: Scaffold(
        appBar: appBar(context),
        body: Container(
          color: ConstColors.backgroundWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                color: ConstColors.backgroundWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Изображение товара
                    Container(
                      width: double.maxFinite,
                      child: AspectRatio(
                        aspectRatio: 1/1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: _food.getImage(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    //Наименование, описание
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              _food.name,
                              style: const TextStyle(
                                fontSize: 19,
                                color: ConstColors.textDark,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Expanded(
                              child: Text(
                                _food.structure,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: ConstColors.textDark,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Цена
              Container(
                height: 70,
                width: double.maxFinite,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                decoration: const BoxDecoration(
                  color: ConstColors.backgroundSuperLight,
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: ConstColors.unselectedTabText,
                    )
                  )
                ),
                child: Text(
                  '${_food.cost.toString()} ₽',
                  style: const TextStyle(
                    fontSize: 22,
                    color: ConstColors.textOrange,
                    fontFamily: 'VelaSans',
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  AppBar appBar(BuildContext context){
    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: ConstColors.backgroundWhite,
      title: Row(
        children: [
          Container(
            width: 40,
            child: TextButton(
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                padding: EdgeInsets.zero,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: Container(
                color: ConstColors.backgroundWhite,
                child: const Icon(
                  Icons.arrow_back,
                  color: ConstColors.textOrange,
                ),
              ),
            ),
          ),
          const Text(
            "Назад",
            style: TextStyle(
              color: ConstColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}