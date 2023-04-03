package com.example.wh

import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.*

class MainActivity : FlutterActivity() {

    companion object{
        const val METHOD_GET_FLUTTER_INFO = "getFlutterInfo"
    }
    var eventSink :EventChannel.EventSink?= null
    // Activity 初始化Flutter引擎 回调
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        basicMessageChannel()
        eventChannel()
        methodChannel()
    }

    fun basicMessageChannel() {
        // 初始化 BasicMessageChannel 并传入名称，名称要和Dart端一致
        var channel = BasicMessageChannel(
            flutterEngine?.dartExecutor!!.binaryMessenger,
            "messageChannel",
            StringCodec.INSTANCE
        )
//  通过BasicMessageChannel实例注册接受回调，并且返回ack
        channel.setMessageHandler { message, reply ->
            Log.d("flutter", "android receive message : ${message}")
            reply.reply("Android 端将信息传递给Flutter---------------")


        }
        // 通过 BasicMessageChannel实例发送消息给Dart
        channel.send("hello from android-------------------------->>>>>>")
    }

    fun eventChannel() {
        // 初始化eventChannel 并传入名称，名称需要和Dart端一致
        val eventChannel = EventChannel(flutterEngine?.dartExecutor!!.binaryMessenger,"eventChannel")
        // 设置事件流的handler
        eventChannel.setStreamHandler(object :EventChannel.StreamHandler{
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
                Handler(Looper.getMainLooper()).postDelayed({
                eventSink?.success("Ack form android")         // doSomething

                },1000)
            }

            override fun onCancel(arguments: Any?) {
            }
        })

    }

    fun methodChannel() {
     val channel =   MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger,"methodChannel")
        //注册MethodChannl 处理器
        channel.setMethodCallHandler { methodCall: MethodCall, result:MethodChannel.Result ->
            if (methodCall.method == METHOD_GET_FLUTTER_INFO) {
                val name = methodCall.argument<String> ("name")
                val version = methodCall.argument<String>("version")
                val language = methodCall.argument<String>("language")
                val androidApi = methodCall.argument<Int>("android_api")
                Log.d("flutter","name=${name}")

             result.success("from android ")
            }
        }
    }
}
