import 'product.dart';

class Store {
  String id;
  String name;
  String description;
  List<Product> products = [];

  Store({required this.id, required this.name, required this.description});
}