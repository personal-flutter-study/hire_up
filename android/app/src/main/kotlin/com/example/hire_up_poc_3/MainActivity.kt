package com.example.hire_up_poc_3

import android.content.Intent
import android.content.Intent.ACTION_SEND
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)




        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, "com.example.hire_up_poc_3_m"
        ).setMethodCallHandler(this)


    }

    override fun onMethodCall(
        p0: MethodCall, p1: MethodChannel.Result
    ) {


        when (p0.method) {
            "share" -> {
                val text = p0.argument<String>("text")
                if (text == null) {
                    p1.success(false)
                    return
                }
                shareText(text)
                p1.success(true)
                return
            }
        }

        p1.notImplemented()


    }


    fun shareText(text: String) {
        val sendIntent: Intent = Intent().apply {
            action = ACTION_SEND
            putExtra(Intent.EXTRA_TEXT, text)
            type = "text/plain"
        }

        val shareIntent = Intent.createChooser(sendIntent, null)
        context.startActivity(shareIntent)
    }


}
