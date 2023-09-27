import 'package:flutter/material.dart';

import '../components/product_list.dart';
import '../models/store.dart';
import '../utils/user_data.dart';

class StoreScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  Store _selectedStore = Store(id: 'NULL', name: '', description: '');

  @override
  Widget build(BuildContext context) {
    if (_selectedStore.id == 'NULL')
      _selectedStore = ModalRoute.of(context)!.settings.arguments as Store;

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedStore.name),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, _selectedStore);
          return false;
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Text(_selectedStore.description,
                      style: Theme.of(context).textTheme.headlineSmall)),
              _selectedStore.products.isEmpty
                  ? const Text('Não há produtos cadastrados')
                  : ProductList(productList: _selectedStore.products),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: UserData.currentUser == ''
            ? null
            : () {
                Navigator.pushNamed(context, '/user/history');
              },
        backgroundColor: UserData.currentUser == ''
            ? Colors.blueGrey
            : Colors.lightBlueAccent,
        child: const Icon(Icons.shopping_cart_checkout),
      ),
    );
  }
}
