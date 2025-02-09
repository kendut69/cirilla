package com.bsvtech.shop
import android.app.Application
import io.maido.intercom.IntercomFlutterPlugin
class MyApp : Application() {
  override fun onCreate() {
    super.onCreate()
    // Initialize the Intercom SDK here also as Android requires to initialize it in the onCreate of
    // the application.
    IntercomFlutterPlugin.initSdk(this, appId = "afxz2a2a", androidApiKey = "android_sdk-f3ab642ba2d7bcf1967197eb2304507ba31c6814")
  }
}