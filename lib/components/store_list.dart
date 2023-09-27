import 'package:flutter/material.dart';

import '../models/store.dart';

class StoreList extends StatelessWidget {
  final List<Store> storeList;

  StoreList({required this.storeList});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
          itemCount: storeList.length,
          itemBuilder: (context, index) {
            final store = storeList[index];
            return InkWell(
              onTap: () async {
                await Navigator.of(context).pushNamed(
                  '/store',
                  arguments: storeList[index],
                ).then((value) {
                  if (value != null) {
                    var st = value as Store;
                    storeList[index] = st;
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
                      child: Text(store.name,
                        style: Theme.of(context).textTheme.titleMedium
                          ?.merge(TextStyle(color: Theme.of(context).colorScheme.primary)
                        )
                      ),
                    ),
                    Text(store.description)
                  ],
                ),
              ),
            );
          }),
    );
  }
}