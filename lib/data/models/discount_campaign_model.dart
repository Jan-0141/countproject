enum DiscountCategory {
  coupon,
  onTop,
  seasonal,
}

abstract class DiscountCampaign {
  final DiscountCategory category;
  DiscountCampaign(this.category);
}

// ──────────────────────────────────────────────
// 1. Fixed Amount Coupon (ลดราคาตายตัวทั้งตะกร้า)
class FixedAmountCoupon extends DiscountCampaign {
  final double amount;
  FixedAmountCoupon(this.amount) : super(DiscountCategory.coupon);
}

// 2. Percentage Coupon (ลดทั้งตะกร้าร้อยละ)
class PercentageCoupon extends DiscountCampaign {
  final double percentage;
  PercentageCoupon(this.percentage) : super(DiscountCategory.coupon);
}

// 3. Category Discount (ลดเฉพาะหมวด)
class CategoryPercentageDiscount extends DiscountCampaign {
  final String categoryName;
  final double percentage;
  CategoryPercentageDiscount(this.categoryName, this.percentage)
      : super(DiscountCategory.onTop);
}

// 4. Point Discount (ลดจากแต้ม)
class PointDiscount extends DiscountCampaign {
  final int points;
  PointDiscount(this.points) : super(DiscountCategory.onTop);
}

// 5. Seasonal Discount (ลดทุก ๆ X บาท)
class SeasonalDiscount extends DiscountCampaign {
  final double everyAmount;
  final double discountPerStep;
  SeasonalDiscount(this.everyAmount, this.discountPerStep)
      : super(DiscountCategory.seasonal);
}
