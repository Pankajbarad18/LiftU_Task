part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  final int categoryId;

  HomeInitialEvent({required this.categoryId});
}

class HomeLikeCLicked extends HomeEvent {
  final ProductModel itemclicked;

  HomeLikeCLicked(this.itemclicked);
}

class HomeCartClicked extends HomeEvent {
  final ProductModel itemclicked;

  HomeCartClicked(this.itemclicked);
}

class NavigatetoWishlist extends HomeEvent {}

class NavigatetoCart extends HomeEvent {}
