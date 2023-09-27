import 'dart:math';

import 'package:f01_my_hello_word/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';

import '../models/product.dart';
import '../models/order.dart';

class ProductScreen extends StatelessWidget {
  Product _product = Product(id: 'NULL', name: '', description: '', price: 0);
  
  @override
  Widget build(BuildContext context) {
    _product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, _product);
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(_product.name, style: Theme.of(context).textTheme.headlineSmall)
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: _product.description.isEmpty ? const Text('Nenhuma descrição fornecida') : Text('Descrição: ${_product.description}'),
              ),
              const SizedBox(height: 10),
              Text('Preço: R\$ ${_product.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _openTaskFormModal(context, _product);
                },
                label: const Icon(Icons.shopping_cart),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: UserData.currentUser == '' ? null : () {
          Navigator.pushNamed(context, '/user/history');
        },
        child: const Icon(Icons.shopping_cart_checkout),
      ),
    );
  }
  
  void _openTaskFormModal(BuildContext context, Product product) {
    int quantity = 0;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  const Expanded(child: Text('Quantidade:')),
                  Expanded(
                    child: SpinBox(
                      min: 1,
                      max: 99,
                      value: 1,
                      onChanged: (value) => quantity = value.toInt(),
                    ),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  for (var o in UserData.orders) {
                    if (o.userId == UserData.currentUser && !o.isFinished) {
                      if(o.orderProductsQty.keys.contains(product)) {
                        o.orderProductsQty[product] = o.orderProductsQty[product]! + quantity;
                        return;
                      } else {
                        o.orderProductsQty[product] = quantity;
                        return;
                      }
                    }
                  }
                  Order newOrder = Order(id: Random().nextInt(9999).toString(), userId: UserData.currentUser, orderProductsQty: <Product, int>{product: quantity});
                  UserData.orders.add(newOrder);
                  Navigator.of(context).pop();
                },
                child: const Text('Adicionar')
              )
            ],
          ),
        );
      }
    );
  }


}