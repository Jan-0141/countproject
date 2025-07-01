import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'modules/home/home_controller.dart';

void main() {
  Get.put(HomeController());
  runApp(myApp());
}

// ✅ ฟังก์ชันนี้ต้อง return Widget ไม่ใช่ void
Widget myApp() {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Discount App',
    initialRoute: AppRoutes.HOME,
    getPages: AppPages.pages,
  );
}
