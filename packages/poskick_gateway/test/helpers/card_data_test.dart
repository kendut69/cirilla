// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:poskick_gateway/helpers/card_data.dart';

void main() {
  /// Test parse card data case 3 PCRE format
  test('Test parse card data case 3 PCRE format', () {
    String cardDataString = '%B4221498678160624^PHAM THI VIET LINH^2303201102860000000000966000000?;4221498678160624=23032011028696600000?';
    Map<String, dynamic> cardData = parseCardData(cardDataString);
    expect(cardData['card_number'], '4221498678160624');
    expect(cardData['expiration_month'], '03');
    expect(cardData['expiration_year'], '2023');
  });

  /// Test parse card data case 4 PCRE format
  test('Test parse card data case 3 PCRE format', () {
    String cardDataString = '%B4912390049955812^DESILETS/ DAVID^28092010001000769000000?;4912390049955812=280920100010769?';
    Map<String, dynamic> cardData = parseCardData(cardDataString);
    expect(cardData['card_number'], '4912390049955812');
    expect(cardData['expiration_month'], '09');
    expect(cardData['expiration_year'], '2028');
  });

  /// Test card brand
  test('Test card brand', () {
    expect(getCardBrand('4221498678160624'), 'visa');
    expect(getCardBrand('4912390049955812'), 'visa');
    expect(getCardBrand('5425233430109903'), 'mastercard');
    expect(getCardBrand('5425233430109903'), 'mastercard');
    expect(getCardBrand('376449047333005'), 'amex');
    expect(getCardBrand('6011111111111117'), 'discover');
  });
}
