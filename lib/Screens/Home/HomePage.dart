// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodish/Data/API/ApiServices.dart';
import 'package:foodish/Screens/Cart/CartPage.dart';
import 'package:foodish/Screens/Home/Product_Tile.dart';
import 'package:foodish/Screens/Home/bloc/home_bloc.dart';
import 'package:foodish/Screens/Home/widgets/tags.dart';
import 'package:foodish/Screens/WishList/WishListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int selected = 1;

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent(categoryId: 1));
    super.initState();
  }

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
        switch (state.runtimeType) {
          case HomeLoadingBar:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeSucessLoaded:
            final sucessState = state as HomeSucessLoaded;
            return Scaffold(
                appBar: AppBar(title: const Text("Foodish"), actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(NavigatetoWishlist());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(NavigatetoCart());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined))
                ]),
                body: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(12),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "Search Here",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sucessState.category.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = index + 1;
                                  homeBloc.add(
                                      HomeInitialEvent(categoryId: selected));
                                });
                              },
                              child: TagTile(
                                  category: sucessState.category[index],
                                  index: selected),
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: sucessState.products.length,
                          itemBuilder: (context, index) {
                            return ProductTile(
                                homeBloc: homeBloc,
                                productModel: sucessState.products[index]);
                          }),
                    ),
                  ],
                ));
          case HomeErrorLoaded:
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
