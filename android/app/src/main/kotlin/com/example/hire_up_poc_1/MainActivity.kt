package com.example.hire_up_poc_1

import android.Manifest
import android.content.Intent
import android.content.Intent.ACTION_SEND
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.Telephony
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


        if (ContextCompat.checkSelfPermission(
                context,
                android.Manifest.permission.READ_SMS
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(android.Manifest.permission.READ_SMS),
                0
            )
        }

    }

    var result: MethodChannel.Result? = null


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.hire_up_poc_1_m"
        ).setMethodCallHandler(this)


    }

    override fun onMethodCall(
        p0: MethodCall,
        p1: MethodChannel.Result
    ) {

        result = p1


        when (p0.method) {
            "permission" -> {
                result?.success(
                    ContextCompat.checkSelfPermission(
                        context,
                        Manifest.permission.READ_SMS
                    ) == PackageManager.PERMISSION_GRANTED
                );
            }

            "sms" -> {
                readSMS()
            }

            "share" -> {

                val text = p0.argument<String>("text")
                if (text == null) {
                    result?.success(false)
                    return
                }
                shareText(text)
                result?.success(true)

            }


        }


        result?.notImplemented()


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


    fun readSMS() {
        val smsUri = Telephony.Sms.Inbox.CONTENT_URI
        val projection = arrayOf(Telephony.Sms.Inbox.BODY)
        val cursor = context.contentResolver.query(smsUri, projection, null, null, null)

        var resultBody = ""

        cursor?.use {
            val index = it.getColumnIndex(Telephony.Sms.Inbox.BODY)

            if (index != -1 && it.moveToNext()) {
                resultBody = it.getString(index) ?: ""
            }
        }

        result?.success(resultBody)
    }


}
