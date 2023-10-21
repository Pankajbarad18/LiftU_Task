// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:foodish/Screens/Cart/bloc/cart_bloc.dart';
import 'package:foodish/Screens/Home/HomeDataModel/DataModel.dart';

class CartProductTile extends StatelessWidget {
  final ProductModel productModel;
  final CartBloc cartBloc;
  const CartProductTile(
      {super.key, required this.productModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(productModel.images[0]))),
        ),
        Text(
          productModel.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$ ${productModel.price}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      // homeBloc.add(HomeLikeCLicked(productModel));
                    },
                    icon: const Icon(Icons.favorite_border)),
                IconButton(
                    onPressed: () {
                      cartBloc.add(CartRemoveItem(productModel));
                    },
                    icon: const Icon(Icons.shopping_bag))
              ],
            )
          ],
        )
      ]),
    );
  }
}
