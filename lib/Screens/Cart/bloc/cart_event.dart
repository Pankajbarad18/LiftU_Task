part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartSucess extends CartEvent {}

class CartRemoveItem extends CartEvent {
  final ProductModel deleteItem;

  CartRemoveItem(this.deleteItem);
}
