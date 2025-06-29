import 'package:get/get.dart';
import '../../data/models/cart_item_model.dart';

class HomeController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  void addItem(CartItem item) {
    cartItems.add(item);
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);
}
