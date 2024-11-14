package com.example.guid

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.applovin.sdk.AppLovinSdk

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        AppLovinSdk.getInstance(this).initializeSdk()
       
    }
}
