import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wh/main.dart';
import 'package:wh/second_page.dart';

/**
 * 页面路由
 */
class MCRouter extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  static const String mainPage = '/main';
  static const String secondPage = '/second';
  static const String key = 'key';
  static const String value ='value';

  final List<Page> _pages = []; //存储页面结构的列表，通过操作它进行页面的添加与移除
  // 用来做异步操作
  late Completer<Object?> _boolResultCompleter;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey, pages: List.of(_pages), onPopPage: _onPopPage);
  }


  @override
  Future<bool> popRoute({Object? params}) {
    //notifyListeners(); 之后的 回调
    if((params != null)){
      _boolResultCompleter.complete(params);

    }
    if (_canPop()) {
      _pages.removeLast()
          notifyListeners();
          return Future.value(true);

    }
    return _confirmExit();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {

  }

  /**
   * 页面显示后的回调
   * route
   * result
   */
  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;
    if (_canPop()) {
      _pages.removeLast();
      return true;
    } else {
      return false;
    }
  }

  /**
   * 判断page栈长度，为空则即将退出App；不为空则返回true 表示页面关闭
   */
  bool _canPop() {
    return _pages.length > 1;
  }

  void replace({required  String name , dynamic arguments}){
    if (_pages.isNotEmpty) {
    _pages.removeLast();
    }
    push(name: name,argument: arguments);
  }

  /**
   * name 页面名称
   * argument 参数可有可无 也可以时任意类型
   * 开启页面为异步操作
   * 添加页面进栈
   */
  Future<Object?> push({required String name, dynamic argument}) async {
    _boolResultCompleter = Completer<Object?>();
    _pages.add(_createPage(RouteSettings(name: name, arguments: argument)));
    notifyListeners(); // 刷新
    return _boolResultCompleter.future;
  }


  MaterialPage _createPage(RouteSettings routeSettings) {
    Widget page;
    switch (routeSettings.name) {
      case mainPage:
        page = const MyHomePage(title: "My home page");
        break;
      case secondPage:
        page = SecondPage(params: routeSettings.arguments.toString()?? '');
        break;
      default:
        page = const Scaffold();
    }
    return MaterialPage(child: page,
        key: Key(routeSettings.name!) as LocalKey,
        name: routeSettings.name,
        arguments: routeSettings.arguments);
  }

  Future<bool> _confirmExit() async{
    final result = await showDialog<bool>(
        context: navigatorKey.currentContext!, builder: (BuildContext context) {
      return AlertDialog(content: const Text('确认退出吗'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, true),
              child: const Text('取消')),
          TextButton(onPressed: () => Navigator.pop(context, false),
              child: const Text('确定'))
        ],);
    },
    );
    return result?? true;

  }


}