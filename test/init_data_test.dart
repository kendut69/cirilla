// Validate init data
//

import 'package:cirilla/constants/app.dart' as acf;
import 'package:cirilla/constants/credentials.dart' as acc;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Default Configs', () {
    test('Validate app.dart', () {
      const String baseUrl = 'https://shop.bsvtech.com.my/';
      const String consumerKey = 'ck_a5cb6538c6edc0d6590a738eeb04af74a801d6f3';
      const String consumerSecret =
          'cs_8fab14b95c97049085ef7b8aa736f7dd2d597832';
      const String restPrefix = 'wp-json';
      const String defaultLanguage = 'en';
      const List<String> languageSupport = ['en', 'ar', 'tr', 'id'];
      const String googleClientId =
          '295269595518-e7s01ueadskq7sbg2k4g4dfnefpmd7vt.apps.googleusercontent.com';
      expect(acf.baseUrl, baseUrl);
      expect(acf.consumerKey, consumerKey);
      expect(acf.consumerSecret, consumerSecret);
      expect(acf.restPrefix, restPrefix);
      expect(acf.defaultLanguage, defaultLanguage);
      expect(acf.googleClientId, googleClientId);
      expect(acf.languageSupport, languageSupport);
    });

    test('Validate credentials.dart', () {
      const String googleMapApiKey = 'AIzaSyBxd9rcfmSnEFHO46UxgpQfMvIc_vYZ3kc';
      expect(acc.googleMapApiKey, googleMapApiKey);
    });
  });
}
