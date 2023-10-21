import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodish/Screens/Home/HomeDataModel/DataModel.dart';
import 'package:foodish/Screens/Home/bloc/home_bloc.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeBloc();
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is ItemAddedInWishList) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Added to WishList")));
        } else if (state is ItemAddedInCart) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Added to Cart")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Padding(
            padding: const EdgeInsets.only(left: 5, right: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        // margin: const EdgeInsets.only(top: 2, left: 5, right: 5),
                        height: 500,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(product.images[0]),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                          child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        homeBloc.add(HomeLikeCLicked(product));
                                      },
                                      icon: const Icon(Icons.favorite_border)),
                                  IconButton(
                                      onPressed: () {
                                        homeBloc.add(HomeCartClicked(product));
                                      },
                                      icon: const Icon(
                                          Icons.shopping_bag_outlined))
                                ],
                              )
                            ],
                          ),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    product.title,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                        height: 1.5,
                        wordSpacing: 1.5),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.deepPurple[500],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs. ${product.price.toString()}",
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          child: const Text(
                            "Buy Now ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        );
      },
    );
  }
}
