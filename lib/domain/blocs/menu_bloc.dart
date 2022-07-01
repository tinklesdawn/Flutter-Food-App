import 'package:bloc/bloc.dart';
import 'package:foodapp/domain/data_providers/menu_data_provider.dart';
import 'package:meta/meta.dart';

import '../entities/food.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  List<Food> food = [];
  int selectedCategory = 0;

  MenuBloc() : super(MenuCategoryChanged()) {
    initialize();
    on<MenuEvent>((event, emit) {
      // TODO: implement event handler
      if (event is ChangeCategory){
        _changeCategory(event, emit);
      }
    });
  }

  Future<void> initialize() async {
    food = await MenuDataProvider().selectFood(selectedCategory);
  }
  Future<void> _changeCategory(ChangeCategory event, Emitter emit)async {
    selectedCategory = event._category;
    emit(MenuCategoryChanged());
    food = await MenuDataProvider().selectFood(selectedCategory);
}
}
