import 'package:bloc/bloc.dart';
import 'package:foodapp/domain/data_providers/menu_data_provider.dart';
import 'package:meta/meta.dart';

import '../entities/food.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  List<Food> food = [];
  int selectedCategory = 0;

  MenuBloc() : super(MenuInitial()) {
    on<MenuEvent>((event, emit) {
      // TODO: implement event handler
      if (event is ChangeCategory){
        _changeCategory(event, emit);
      }
      if (event is UpdateData){
        emit(MenuCategoryChanged());
        _updateFood();
      }
    });
  }

  Future<void> _changeCategory(ChangeCategory event, Emitter emit) async{
    emit(MenuCategoryChanged());
    selectedCategory = event._category;
    food.clear();
  }

  void _updateFood() async{
    food = await MenuDataProvider().selectFood(selectedCategory);
  }
}
