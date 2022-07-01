part of 'menu_bloc.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}
class MenuCategoryChanged extends MenuState{}
