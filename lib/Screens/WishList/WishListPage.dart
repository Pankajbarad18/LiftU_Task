// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodish/Screens/WishList/WishListFoodTile.dart';
import 'package:foodish/Screens/WishList/bloc/wishlist_bloc.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishListInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ItemforWishList:
              final successState = state as ItemforWishList;
              return ListView.builder(
                  itemCount: successState.wishListItems.length,
                  itemBuilder: (context, index) {
                    return WishListFoodTile(
                        productModel: successState.wishListItems[index],
                        wishlistBloc: wishlistBloc);
                  });
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
