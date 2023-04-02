package com.example.wh

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec

class MainActivity : FlutterActivity() {
    // Activity 初始化Flutter引擎 回调
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
// 初始化 BasicMessageChannel 并传入名称，名称要和Dart端一致
        var channel = BasicMessageChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "messageChannel",
            StringCodec.INSTANCE
        )
//  通过BasicMessageChannel实例注册接受回调，并且返回ack
        channel.setMessageHandler { message, reply ->
            Log.d("flutter","android receive message : ${message}")
            reply.reply("Android 端将信息传递给Flutter---------------")


        }
        // 通过 BasicMessageChannel实例发送消息给Dart
        channel.send("hello from android-------------------------->>>>>>")

    }
}
