part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent {}

class ChangeCategory extends MenuEvent{
  final int _category;

  ChangeCategory(this._category);

}
