import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'service/service.dart';
import 'package:intercom_package/intercom_package.dart';

/// App starts
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePushNotificationService();
  SharedPreferences sharedPref = await getSharedPref();
  intercomInitialize(
    'app_id',
    androidApiKey: 'android_sdk-f3ab642ba2d7bcf1967197eb2304507ba31c6814',
    iosApiKey: 'ios_sdk-064e68f084b2b293241a0784f378d6363329d72e',
  );
  await AppServiceInject.create(
    PreferenceModule(sharedPref: sharedPref),
    NetworkModule(),
  );

  runApp(AppServiceInject.instance.getApp);
}
