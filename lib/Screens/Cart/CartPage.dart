// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodish/Screens/Cart/CartFoodTile.dart';
import 'package:foodish/Screens/Cart/bloc/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartFoodTile(
                        cartBloc: cartBloc,
                        productModel: successState.cartItems[index]);
                  });
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
