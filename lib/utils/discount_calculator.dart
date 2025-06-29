import '../data/models/cart_item_model.dart';
import '../data/models/discount_campaign_model.dart';

class DiscountCalculator {
  static double calculate(
    List<CartItem> items,
    List<DiscountCampaign> campaigns,
  ) {
    double total = items.fold(0.0, (sum, item) => sum + item.price);

    // ──────────── Coupon ──────────────
    final coupon =
        campaigns.where((c) => c.category == DiscountCategory.coupon).toList();
    if (coupon.length > 1) {
      throw Exception("Cannot apply more than one coupon.");
    }
    if (coupon.isNotEmpty) {
      final c = coupon.first;
      if (c is FixedAmountCoupon) {
        total -= c.amount;
      } else if (c is PercentageCoupon) {
        total *= (1 - c.percentage / 100);
      }
    }

    // ──────────── OnTop ──────────────
    final onTop =
        campaigns.where((c) => c.category == DiscountCategory.onTop).toList();

    for (var c in onTop) {
      if (c is CategoryPercentageDiscount) {
        final matchedItems = items
            .where((item) =>
                item.category.toLowerCase() == c.categoryName.toLowerCase())
            .toList();
        final catTotal =
            matchedItems.fold(0.0, (sum, item) => sum + item.price);
        final discount = catTotal * (c.percentage / 100);
        total -= discount;
      } else if (c is PointDiscount) {
        final maxDiscount = total * 0.20;
        final discountFromPoint = c.points.toDouble();
        total -=
            discountFromPoint > maxDiscount ? maxDiscount : discountFromPoint;
      }
    }

    // ──────────── Seasonal ──────────────
    final seasonal = campaigns
        .where((c) => c.category == DiscountCategory.seasonal)
        .toList();
    if (seasonal.length > 1) {
      throw Exception("Cannot apply more than one seasonal campaign.");
    }
    if (seasonal.isNotEmpty) {
      final s = seasonal.first as SeasonalDiscount;
      final steps = (total / s.everyAmount).floor();
      total -= (steps * s.discountPerStep);
    }

    return total < 0 ? 0 : double.parse(total.toStringAsFixed(2));
  }
}
