// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodish/Screens/Cart/CartPage.dart';
import 'package:foodish/Screens/Home/HomeDataModel/DataModel.dart';
import 'package:foodish/Screens/Home/ProductDetails.dart';
import 'package:foodish/Screens/Home/bloc/home_bloc.dart';
import 'package:foodish/Screens/WishList/WishListPage.dart';

class ProductTile extends StatelessWidget {
  final ProductModel productModel;
  final HomeBloc homeBloc;
  const ProductTile(
      {super.key, required this.productModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is CartNavigateClicked) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        } else if (state is LikeNavigateClicked) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishListPage()));
        } else if (state is ItemAddedInWishList) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Item Added Into WishList")));
        } else if (state is ItemAddedInCart) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Item Added Into Cart")));
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                        product: productModel,
                      ))),
          child: Container(
            height: 300,
            width: 300,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(productModel.images[0]))),
              ),
              Text(
                productModel.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$ ${productModel.price}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            homeBloc.add(HomeLikeCLicked(productModel));
                          },
                          icon: const Icon(Icons.favorite_border)),
                      IconButton(
                          onPressed: () {
                            homeBloc.add(HomeCartClicked(productModel));
                          },
                          icon: const Icon(Icons.shopping_bag_outlined))
                    ],
                  )
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}
