package com.example.hire_up_poc_5

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)




        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.hire_up_poc_5_m"
        ).setMethodCallHandler(
            this
        )


    }

    override fun onMethodCall(
        p0: MethodCall,
        p1: MethodChannel.Result
    ) {
        when (p0.method) {

            "t" -> {
                val t = p0.argument<String>("t")
                if (t == null) {
                    p1.success(false)
                    return
                }
                Toast.makeText(this, t, Toast.LENGTH_SHORT).show()
                p1.success(true)
                return

            }

        }
    }

}
