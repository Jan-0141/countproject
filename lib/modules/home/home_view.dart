import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/cart_item_model.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      CartItem(name: 'T-Shirt', price: 350, category: 'Clothing'),
      CartItem(name: 'Hat', price: 250, category: 'Accessories'),
      CartItem(name: 'Watch', price: 850, category: 'Electronics'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('เลือกสินค้า'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text('สินค้าให้เลือก', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: items
                .map((item) => ElevatedButton(
                      onPressed: () => controller.addItem(item),
                      child: Text('${item.name} (${item.price.toInt()}฿)'),
                    ))
                .toList(),
          ),
          const Divider(),
          const Text('สินค้าในตะกร้า', style: TextStyle(fontSize: 18)),
          Obx(() => Expanded(
                child: ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) {
                    final item = controller.cartItems[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.category),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${item.price.toInt()}฿'),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => controller.removeItem(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
          Obx(() => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(
                      'รวมทั้งหมด: ${controller.totalPrice.toStringAsFixed(2)} ฿',
                      style: const TextStyle(fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () => Get.toNamed('/checkout'),
                        child: const Text('ชำระเงิน')),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
