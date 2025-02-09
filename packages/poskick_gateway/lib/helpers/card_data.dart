/// Get card brand from card number
String getCardBrand(String cardNumber) {
  RegExp visaRegex = RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$');
  RegExp masterRegex = RegExp(r'^5[1-5][0-9]{14}$');
  RegExp amexRegex = RegExp(r'^3[47][0-9]{13}$');
  RegExp discoverRegex = RegExp(r'^6(?:011|5[0-9]{2})[0-9]{12}$');
  RegExp dinersRegex = RegExp(r'^3(?:0[0-5]|[68][0-9])[0-9]{11}$');
  RegExp jcbRegex = RegExp(r'^(?:2131|1800|35\d{3})\d{11}$');

  if (visaRegex.hasMatch(cardNumber)) {
    return 'visa';
  } else if (masterRegex.hasMatch(cardNumber)) {
    return 'mastercard';
  } else if (amexRegex.hasMatch(cardNumber)) {
    return 'amex';
  } else if (discoverRegex.hasMatch(cardNumber)) {
    return 'discover';
  } else if (dinersRegex.hasMatch(cardNumber)) {
    return 'diners';
  } else if (jcbRegex.hasMatch(cardNumber)) {
    return 'jcb';
  } else {
    return 'unknown';
  }
}

/// Get card data from PCRE format
Map<String, String> parseCardData(String cardData) {
  Map<String, String> cardDetails = {};

  // Extract the card number start with B end with ^ character and 16 digits
  RegExp numberRegex = RegExp(r'^%B(\d{16})\^');

  Iterable<Match> numberMatches = numberRegex.allMatches(cardData);
  if (numberMatches.isNotEmpty) {
    Match numberMatch = numberMatches.first;
    cardDetails['number'] = numberMatch?.group(1) ?? '';
  }

  // Extract the card expiration date after ^ character with 4 digits
  RegExp expirationRegex = RegExp(r'\^(\d{2})(\d{2})');
  Iterable<Match> expirationMatches = expirationRegex.allMatches(cardData);
  if (expirationMatches.isNotEmpty) {
    Match expirationMatch = expirationMatches.first;
    cardDetails['expiration_month'] = expirationMatch?.group(2) ?? '';
    cardDetails['expiration_year'] = '20${expirationMatch?.group(1)}';
  }

  return cardDetails;
}