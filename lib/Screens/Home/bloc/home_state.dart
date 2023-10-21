part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

//Normal state will extends the HomeState
//that will build the normal ui part into that page
class HomeLoadingBar extends HomeState {}

class HomeSucessLoaded extends HomeState {
  final List<ProductModel> products;
  final List<Category> category;

  HomeSucessLoaded({required this.category, required this.products});
}

class HomeErrorLoaded extends HomeState {}

class LikeClicked extends HomeState {}

class CartClicked extends HomeState {}

//Action state will extends by the class where we required to do some actions
//like navigate to another page

class LikeNavigateClicked extends HomeActionState {}

class CartNavigateClicked extends HomeActionState {}

class ItemAddedInCart extends HomeActionState {}

class ItemAddedInWishList extends HomeActionState {}
