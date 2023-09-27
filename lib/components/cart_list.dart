import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/order.dart';

class CartList extends StatelessWidget {
  final Order cart;

  CartList({required this.cart});

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for(Product p in cart.orderProductsQty.keys.toList()) {
      totalPrice += p.price * cart.orderProductsQty[p]!;
    }

    return Container(
      height: 600,
      child: Column(
        children: [
          SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cart.orderProductsQty.length,
              itemBuilder: (context, index) {
                Product product = cart.orderProductsQty.keys.toList()[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(child: Text(product.name, style: Theme.of(context).textTheme.titleMedium)),
                        const SizedBox(width: 20),
                        Text('${product.price.toStringAsFixed(2)} x ${cart.orderProductsQty[product]}')
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
          Text('Total: R\$ $totalPrice'),
        ],
      ),
    );
  }

}