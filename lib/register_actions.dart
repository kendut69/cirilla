import 'package:flutter/material.dart';
import 'package:intercom_package/intercom_package.dart';
/// Import package here

/// Register actions
///
/// [route] is the route to navigate
/// [context] is the current context
/// [action] is the action to handle
///
/// Return [route] to navigate, none return if no action
Future<String> registerActions(String route, BuildContext context, Map<String, dynamic>? action) async {
  if (route == '/intercom') {
    await  intercomInstance.loginUnidentifiedUser();
    await intercomInstance.displayMessenger();
    return 'none';
  }
  /// Handle action here

  return route;
}