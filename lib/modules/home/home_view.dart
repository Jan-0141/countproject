import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/cart_item_model.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สินค้า')),
      body: Obx(() => Column(
            children: [
              // ───── แสดงสินค้าเป็น Grid ─────
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: controller.availableProducts.length,
                  itemBuilder: (_, index) {
                    final item = controller.availableProducts[index];
                    return ProductCard(item: item);
                  },
                ),
              ),

              // ───── รวมราคาสินค้า + ปุ่มชำระเงิน ─────
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          'รวม: ${controller.totalPrice.toStringAsFixed(2)} ฿',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    ElevatedButton.icon(
                      onPressed: () => Get.toNamed('/checkout'),
                      icon: const Icon(Icons.shopping_cart_checkout),
                      label: const Text('ชำระเงิน'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class ProductCard extends StatelessWidget {
  final CartItem item;
  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── รูป ───
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // ─── ชื่อสินค้า ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4),
          // ─── ราคา ───
          Text(
            '${item.price.toInt()} ฿',
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // ─── ปุ่มเพิ่มสินค้า ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () => controller.addItem(item),
              child: const Text('เพิ่มลงตะกร้า'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
