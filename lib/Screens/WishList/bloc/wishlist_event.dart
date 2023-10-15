part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishListInitial extends WishlistEvent {}

class SuccessItem extends WishlistEvent {}

class RemoveItem extends WishlistEvent {
  final ProductModel deleteItem;

  RemoveItem({required this.deleteItem});
}
