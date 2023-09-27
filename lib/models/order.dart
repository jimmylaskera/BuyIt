import 'product.dart';

class Order {
  String id;
  String userId;
  DateTime timeCreated = DateTime.now();
  Map<Product, int> orderProductsQty;
  bool isFinished = false;

  Order({required this.id, required this.userId, required this.orderProductsQty});
}