package com.example.hire_up_poc_1

import android.Manifest
import android.content.Intent
import android.content.Intent.ACTION_SEND
import android.content.pm.PackageManager
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaPlayer
import android.media.MediaRecorder
import android.media.audiofx.Visualizer
import android.os.Bundle
import android.provider.Telephony
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import androidx.core.net.toUri
import kotlin.math.pow
import kotlin.math.sqrt

class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler,
    EventChannel.StreamHandler, Visualizer.OnDataCaptureListener {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (ContextCompat.checkSelfPermission(
                context, Manifest.permission.READ_SMS
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this, arrayOf(Manifest.permission.READ_SMS), 0
            )
        }
    }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, "com.example.hire_up_poc_1_m"
        ).setMethodCallHandler(this)
        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger, "com.example.hire_up_poc_1_e"
        ).setStreamHandler(this)
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


    var result: MethodChannel.Result? = null
    override fun onMethodCall(
        p0: MethodCall, p1: MethodChannel.Result
    ) {
        result = p1
        when (p0.method) {
            "permission" -> {
                result?.success(
                    ContextCompat.checkSelfPermission(
                        context, Manifest.permission.READ_SMS
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

            "record" -> {
                val audioRecorder =
                    AudioRecord.Builder().setAudioSource(MediaRecorder.AudioSource.MIC)
                        .setAudioFormat(
                            AudioFormat.Builder().setSampleRate(44100)
                                .setEncoding(AudioFormat.ENCODING_PCM_16BIT).setChannelMask(
                                    AudioFormat.CHANNEL_IN_MONO
                                ).build()
                        ).setBufferSizeInBytes(
                            AudioRecord.getMinBufferSize(
                                44100, AudioFormat.CHANNEL_IN_MONO,
                                AudioFormat.ENCODING_PCM_16BIT
                            )
                        ).build()
            }

            "audio_play" -> {
                mediaPlayer?.start()
                result?.success(true)
                return
            }

            "audio_pause" -> {
                mediaPlayer?.pause()
                result?.success(true)
                return
            }

            "audio_start" -> {
                val uri = p0.argument<String>("uri")
                if (uri == null) {
                    result?.success(false)
                    return
                }
                stop()
                mediaPlayer = MediaPlayer().apply {
                    setDataSource(uri)
                    setOnPreparedListener { mp ->
                        start()
                        setVisualizer(mp.audioSessionId)
                    }
                    prepareAsync()
                }
                result?.success(true)
                return
            }

            "audio_stop" -> {
                stop()
                result?.success(true)
                return
            }
        }
        result?.notImplemented()
    }


    fun stop() {
        mediaPlayer?.release()
        mediaPlayer = null
        visualizer?.release()
        visualizer = null
    }

    var mediaPlayer: MediaPlayer? = null
    var visualizer: Visualizer? = null

    fun setVisualizer(id: Int) {
        visualizer = Visualizer(id)
        visualizer?.apply {
            captureSize = Visualizer.getCaptureSizeRange()[1]
            setDataCaptureListener(
                this@MainActivity,
                Visualizer.getMaxCaptureRate() / 2,
                true,
                false
            )

            enabled = true
        }
    }

    var eventSink: EventChannel.EventSink? = null
    override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
        eventSink = p1
    }

    override fun onCancel(p0: Any?) {
        eventSink = null
    }

    override fun onFftDataCapture(
        p0: Visualizer?,
        p1: ByteArray?,
        p2: Int
    ) {
    }

    override fun onWaveFormDataCapture(
        p0: Visualizer?,
        p1: ByteArray?,
        p2: Int
    ) {
        var root = 0.0
        p1?.let {
            p1.forEach {
                root += it.toDouble().pow(2)
            }
            (root / p1.size).let {
                eventSink?.success(
                    mapOf<String, Any?>(
                        "position" to mediaPlayer?.currentPosition,
                        "volume" to it
                    )
                )
            }
        }

    }


}
