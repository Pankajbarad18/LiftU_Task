import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodish/Data/cart_item.dart';
import 'package:foodish/Screens/Home/HomeDataModel/DataModel.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);

    on<CartRemoveItem>(cartRemoveItem);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveItem(CartRemoveItem event, Emitter<CartState> emit) {
    cartItems.remove(event.deleteItem);
    emit(CartSuccessState(cartItems: cartItems));
  }
}
