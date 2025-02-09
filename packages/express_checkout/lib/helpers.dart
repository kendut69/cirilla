import 'dart:math';

String formatPrice(String total, int unit) {
  int u = unit > 0 ? pow(10, unit) as int : 1;
  double price = double.tryParse(total) ?? 0;
  return (price / u).toString();
}

int getUnit(Map<String, dynamic>? cartData) {
  if (cartData?["totals"] != null && cartData!["totals"]?["currency_minor_unit"] != null) {
    return int.tryParse("${cartData["totals"]["currency_minor_unit"]}") ?? 0;
  }
  return 0;
}