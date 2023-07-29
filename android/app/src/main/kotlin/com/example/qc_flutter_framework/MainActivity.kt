package com.example.qc_flutter_framework

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import android.os.Handler
import android.os.CountDownTimer

class MainActivity: FlutterActivity() {

    private val CHANNEL = "samples.flutter.dev/platform_channel"

    private lateinit var gchannel : MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //channel 监听
        var channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        gchannel = channel;
        

        gchannel.setMethodCallHandler { call, result ->
            // 根据 call.method 来判断方法名，并执行相应的逻辑
            when (call.method) {
                "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
                else -> result.notImplemented()
            }
        }

        /** call 
         *
         * Android端应当延迟MethodChannel调用,确保Flutter已经初始化完成。
         * 把MethodChannel调用移出configureFlutterEngine(),改在适当的时机调用。
         * 例如一个按钮里 
         * gchannel.invokeMethod("randomNumberGenerated", 2) 
         */

    }

}
