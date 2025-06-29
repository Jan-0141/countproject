import 'package:get/get.dart';
import '../../data/models/discount_campaign_model.dart';
import '../../utils/discount_calculator.dart';
import '../home/home_controller.dart';

class CheckoutController extends GetxController {
  final HomeController homeController = Get.find();

  RxList<DiscountCampaign> selectedCampaigns = <DiscountCampaign>[].obs;
  RxDouble finalPrice = 0.0.obs;

  @override
  void onInit() {
    calculateFinalPrice();
    super.onInit();
  }

  void calculateFinalPrice() {
    finalPrice.value = DiscountCalculator.calculate(
      homeController.cartItems,
      selectedCampaigns,
    );
  }

  void addCampaign(DiscountCampaign campaign) {
    // Remove existing of same category
    selectedCampaigns.removeWhere((c) => c.category == campaign.category);
    selectedCampaigns.add(campaign);
    calculateFinalPrice();
  }
}
