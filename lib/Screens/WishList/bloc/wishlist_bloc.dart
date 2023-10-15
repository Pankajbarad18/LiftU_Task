import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodish/Data/wishlist_items.dart';
import 'package:foodish/Screens/Home/HomeDataModel/DataModel.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishListInitial>(wishListInitial);

    on<RemoveItem>(removeItem);
  }

  FutureOr<void> wishListInitial(
      WishListInitial event, Emitter<WishlistState> emit) {
    emit(ItemforWishList(wishListItems: wishListItems));
  }

  FutureOr<void> removeItem(RemoveItem event, Emitter<WishlistState> emit) {
    wishListItems.remove(event.deleteItem);
    emit(ItemforWishList(wishListItems: wishListItems));
  }
}
