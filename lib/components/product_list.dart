import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> productList;

  ProductList({required this.productList});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            Product product = productList[index];
            return InkWell(
              onTap: () async {
                await Navigator.of(context).pushNamed(
                  '/store/product',
                  arguments: product,
                ).then((value) {
                  if (value != null) {
                    var pt = value as Product;
                    productList[index] = pt;
                  }
                });
              },
              child: Card(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(product.price.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.titleMedium
                      ),
                    ),
                    Text(product.name)
                  ],
                ),
              ),
            );
          }),
    );
  }
}