part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

final class WishlistInitial extends WishlistState {}

class ItemforWishList extends WishlistState {
  final List<ProductModel> wishListItems;

  ItemforWishList({required this.wishListItems});
}
