import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodish/Data/API/ApiServices.dart';
import 'package:foodish/Data/FoodModel.dart';
import 'package:foodish/Data/cart_item.dart';
import 'package:foodish/Data/wishlist_items.dart';
import 'package:foodish/Screens/Home/HomeDataModel/DataModel.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<NavigatetoWishlist>(navigatetoWishlist);

    on<NavigatetoCart>(navigatetoCart);

    on<HomeLikeCLicked>(homeLikeCLicked);

    on<HomeCartClicked>(homeCartClicked);
  }

  Future<FutureOr<void>> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingBar());
    FoodProduct.foodProductList =
        await APIServices.getCategoryProducts(event.categoryId);
    FoodProduct.foodCategoryList = await APIServices.getCategory();
    emit(HomeSucessLoaded(
        products: FoodProduct.foodProductList!,
        category: FoodProduct.foodCategoryList!));
  }

  FutureOr<void> navigatetoCart(NavigatetoCart event, Emitter<HomeState> emit) {
    emit(CartNavigateClicked());
  }

  FutureOr<void> navigatetoWishlist(
      NavigatetoWishlist event, Emitter<HomeState> emit) {
    emit(LikeNavigateClicked());
  }

  FutureOr<void> homeCartClicked(
      HomeCartClicked event, Emitter<HomeState> emit) {
    cartItems.add(event.itemclicked);

    emit(ItemAddedInCart());
  }

  FutureOr<void> homeLikeCLicked(
      HomeLikeCLicked event, Emitter<HomeState> emit) {
    wishListItems.add(event.itemclicked);

    emit(ItemAddedInWishList());
  }
}
