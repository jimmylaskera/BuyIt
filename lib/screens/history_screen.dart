import 'package:f01_my_hello_word/models/order.dart';
import 'package:f01_my_hello_word/utils/user_data.dart';
import 'package:flutter/material.dart';

import '../components/cart_list.dart';
import '../components/order_list.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Histórico'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Carrinho'),
              Tab(text: 'Finalizadas')
            ]
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _getCart(),
            OrderList()
          ]
        ),
      ),
    );
  }
  
  Container _getCart() {
    Order cart = Order(id: 'NULL', userId: '', orderProductsQty: {});
    for (var o in UserData.orders) {
      if (o.userId == UserData.currentUser && !o.isFinished) {
        cart = o;
        break;
      }
    }

    return Container(
      child: cart.id == 'NULL' ? const Text('Carrinho vazio') :
        Column(
          children: <Widget>[
            CartList(cart: cart),
            ElevatedButton(onPressed: () {
              setState(() {
                cart.isFinished = true;
              });
            }, child: const Text('Comprar'))
          ],
        ),
    );
  }
}