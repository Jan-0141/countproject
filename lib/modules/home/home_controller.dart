import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../data/models/cart_item_model.dart';

class HomeController extends GetxController {
  RxList<CartItem> availableProducts = <CartItem>[].obs;
  RxList<CartItem> cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockProducts();
  }

  Future<void> loadMockProducts() async {
    final String jsonStr =
        await rootBundle.loadString('assets/mock/products.json');
    final List<dynamic> jsonList = json.decode(jsonStr);

    availableProducts.value =
        jsonList.map((e) => CartItem.fromJson(e)).toList();
  }

  void addItem(CartItem item) => cartItems.add(item);
  void removeItem(int index) => cartItems.removeAt(index);

  double get totalPrice => cartItems.fold(0.0, (sum, item) => sum + item.price);
}
