import 'package:countproject/app/routes/app_routes.dart';
import 'package:countproject/modules/home/home_view.dart';
import 'package:get/get.dart';

import '../../modules/checkout/checkout_binding.dart';
import '../../modules/checkout/checkout_view.dart';
import '../../modules/home/home_binding.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
  ];
}
