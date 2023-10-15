import 'dart:async';

import 'package:bloc/bloc.dart';
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
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeSucessLoaded(
        products: FoodProduct.foodProductList
            .map((e) => ProductModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageURL: e['imageUrl'],
                rating: e['rating']))
            .toList()));
  }

  FutureOr<void> navigatetoCart(NavigatetoCart event, Emitter<HomeState> emit) {
    print('navigation button clicked');
    emit(CartNavigateClicked());
  }

  FutureOr<void> navigatetoWishlist(
      NavigatetoWishlist event, Emitter<HomeState> emit) {
    print('wishlist navigation button clicked');
    emit(LikeNavigateClicked());
  }

  FutureOr<void> homeCartClicked(
      HomeCartClicked event, Emitter<HomeState> emit) {
    print('cart is clicked');
    cartItems.add(event.itemclicked);

    emit(ItemAddedInCart());
  }

  FutureOr<void> homeLikeCLicked(
      HomeLikeCLicked event, Emitter<HomeState> emit) {
    print('like is clicked');
    wishListItems.add(event.itemclicked);

    emit(ItemAddedInWishList());
  }
}
