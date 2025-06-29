import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/discount_campaign_model.dart';
import '../home/home_controller.dart';
import 'checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('ชำระเงิน')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text('สินค้าในตะกร้า', style: TextStyle(fontSize: 18)),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: homeController.cartItems.length,
                  itemBuilder: (_, index) {
                    final item = homeController.cartItems[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.category),
                      trailing: Text('${item.price} ฿'),
                    );
                  },
                )),
          ),
          const Divider(),
          const Text('เลือกส่วนลด', style: TextStyle(fontSize: 18)),
          Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () => controller.addCampaign(FixedAmountCoupon(50)),
                child: const Text('ลดคงที่ 50฿'),
              ),
              ElevatedButton(
                onPressed: () => controller.addCampaign(PercentageCoupon(10)),
                child: const Text('ลด 10%'),
              ),
              ElevatedButton(
                onPressed: () => controller
                    .addCampaign(CategoryPercentageDiscount('Clothing', 15)),
                child: const Text('ลด 15% เฉพาะ Clothing'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() => Text(
                'ราคาสุทธิ: ${controller.finalPrice.toStringAsFixed(2)} ฿',
                style: const TextStyle(fontSize: 20),
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
