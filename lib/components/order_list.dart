import 'package:f01_my_hello_word/models/product.dart';
import 'package:f01_my_hello_word/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Order> userOrders = [];
    List<double> ordersTotals = [];
    for (Order o in UserData.orders) {
      double total = 0;
      if (o.userId == UserData.currentUser && o.isFinished) {
        userOrders.add(o);
        for (Product p in o.orderProductsQty.keys.toList()) {
          total += p.price * o.orderProductsQty[p]!;
        }
        ordersTotals.add(total);
      }
    }

    return Container(
      height: 600,
      child: userOrders.isEmpty ? const Text('Nenhuma compra cadastrada') : SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: userOrders.length,
            itemBuilder: (context, index) {
              Order order = userOrders[index];
              return Card(
                  child: Column(
                    children: [
                      Text(DateFormat('dd/MM/y').format(order.timeCreated)),
                      SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: order.orderProductsQty.length,
                          itemBuilder: (context, i) {
                            Product product = order.orderProductsQty.keys.toList()[i];
                            return Row(
                              children: [
                                Expanded(child: Text(product.name, style: Theme.of(context).textTheme.titleMedium)),
                                const SizedBox(width: 20),
                                Text('${product.price.toStringAsFixed(2)} x ${order.orderProductsQty[product]}')
                              ],
                            );
                          }
                        ),
                      ),
                      Text('Total: R\$ ${ordersTotals[index].toStringAsFixed(2)}'),
                    ],
                  ),
                );
            }),
      ),
    );
  }

}