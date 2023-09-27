/* import 'dart:developer';

import 'package:flutter/foundation.dart'; */
import 'package:f01_my_hello_word/utils/user_data.dart';
import 'package:flutter/material.dart';

import '../components/store_list.dart';
import '../models/product.dart';
import '../models/store.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  final List<User> _users = [];
  final List<Store> _stores = [
    Store(id: '1', name: 'Loja 1', description: 'Loja 1'),
    Store(id: '2', name: 'Loja 2', description: 'Loja 2'),
    Store(id: '3', name: 'Loja 3', description: 'Loja 3')
  ];
  final List<Product> _products = [
    Product(id: '1', name: 'Produto 1', description: 'Produto 1', price: 1.99),
    Product(id: '2', name: 'Produto 2', description: 'Produto 2', price: 2.99),
    Product(id: '3', name: 'Produto 3', description: 'Produto 3', price: 3.99),
    Product(id: '4', name: 'Produto 4', description: 'Produto 4', price: 4.99),
    Product(id: '5', name: 'Produto 5', description: 'Produto 5', price: 5.99),
    Product(id: '6', name: 'Produto 6', description: 'Produto 6', price: 6.99),
  ];

  @override
  void initState() {
    super.initState();
    _stores[0].products.addAll([_products[0], _products[1]]);
    _stores[1].products.add(_products[2]);
    _stores[2].products.addAll([_products[3], _products[4], _products[5]]);
  }

  @override
  Widget build(BuildContext context) {
    IconButton isNotLogged = IconButton(
    onPressed: () async {
          await Navigator.of(context).pushNamed(
            '/login',
            arguments: _users,
          ).then((loggedUser) {
            if (loggedUser != null) {
              setState(() => UserData.currentUser = loggedUser as String);
            }
          });
        },
    icon: const Icon(Icons.person_outline)
  );

  var isLogged = IconButton(
    onPressed: () async {
      await Navigator.of(context).pushNamed(
        '/user',
        arguments: _users[_users.indexWhere((element) => element.id == UserData.currentUser)],
      ).then((value) {
        if (value != null && UserData.currentUser != '') {
          var user = value as User;
          _users[_users.indexWhere((element) => element.id == UserData.currentUser)] = user;
        }
        setState(() {});
      });
    },
    icon: const Icon(Icons.person)
  );
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('BuyIt'),
        actions: [
          UserData.currentUser == '' ? isNotLogged : isLogged,
        ],
      ),
      body: Column(
        children: [
          _stores.isNotEmpty ? StoreList(storeList: _stores) : const Text('Nenhuma loja cadastrada')
        ]),
      floatingActionButton: FloatingActionButton(
        onPressed: UserData.currentUser == '' ? null : () {
          Navigator.pushNamed(context, '/user/history');
        },
        child: const Icon(Icons.shopping_cart_checkout),
      ),
    );
  }

}