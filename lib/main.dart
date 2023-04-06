import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wh/mc_router.dart';

void main() {
  runApp(const MyApp());
}
var router =  MCRouter(); // 创建Router

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: Router(routerDelegate: router,backButtonDispatcher: RootBackButtonDispatcher(),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // const 定义常量
  static const _channel = BasicMessageChannel('messageChannel',StringCodec());//消息通道 传递字符串 和半结构化信息
  static const _eventChannel = EventChannel('eventChannel');
  static const _methodChannel = MethodChannel('methodChannel');
  String? _message;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 通过BasicMessageChannel 实例，注册一个接收回调，并且返回信息
    _channel.setMessageHandler((message) async {// 注册监听
      print('receive message: $message');
      setState(() {
       _message = message;
      });
      return "aaaaa";
    });
    // 注册广播流监听
    _eventChannel.receiveBroadcastStream().listen((event) {

        print('Receive event: $event');
            setState(() {
              _message = event;
            });
    });

     getFlutterInfo();


  }

  Future<String> getFlutterInfo() async {
       final Map<String,dynamic> map = {
      'name':'flutter',
    'version':'3.0.1',
    'language':'dart',
    'android_api':21
    };
    String result = await _methodChannel.invokeMethod('getFlutterINfo',map);
    return result;
  }

  Future<void> _sendMessage() async{
    //异步写法：  .then()
// _channel.send('hello').then((value) => null)
  //阻塞式 同步写法  函数只执行一句话  使用await或then 都可以  如果上方还有逻辑，上下存在时序问题 选用then
    String? message =  await _channel.send('flutter端将信息传给Android----------------------');
    print('send message $message');

  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

 Future<void> _jumpToPage()async{
   // var ack = await router.push(name: MCRouter.secondPage,argument: {MCRouter.key:'来自主页面（mainPage）'});
    var ack = await router.push(name: MCRouter.secondPage,argument: '来自主页面（mainPage）');
    print('_jumpToPage: $ack');

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        // onPressed: _sendMessage,
        onPressed: _jumpToPage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
