
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../utils/colors.dart';
import '../../widgets/cart_product_card.dart';
import '../../widgets/top_container.dart';

class CartDisplayScreen extends StatelessWidget {
  const CartDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        children: [
          TopContainer(
            title: 'Cart',
            searchBarTitle: "search Product",
            isSearch: false,
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return Container(
                  padding: EdgeInsets.zero,
                  height: size.height*.48,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.cart
                        .productQuantity(state.cart.products)
                        .keys
                        .length,
                    itemBuilder: (context, index) {
                      return CartProductCard(
                        product: state.cart
                            .productQuantity(state.cart.products)
                            .keys
                            .elementAt(index),
                        quantity: state.cart
                            .productQuantity(state.cart.products)
                            .values
                            .elementAt(index),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(
            height: size.height*.05,
          ),
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartLoaded) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: kPrimaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      state.cart.totalString,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: kPrimaryColor,
            ),
            onPressed: () {},
            child: const Text("Chekout"),
          ),
           const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
