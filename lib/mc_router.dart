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
  static const String secondPage ='/second';
  final List<Page> _pages = []; //存储页面结构的列表，通过操作它进行页面的添加与移除
  // 用来做异步操作
  late Completer<Object?>  _boolResultCompleter;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey, pages: List.of(_pages), onPopPage: _onPopPage);
  }


  @override
  Future<bool> popRoute() {//notifyListeners(); 之后的 回调

  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async{

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

  bool _canPop() {
    return _pages.length > 1;
  }

  /**
   * name 页面名称
   * argument 参数可有可无 也可以时任意类型
   * 开启页面为异步操作
   * 添加页面进栈
   */
  Future<Object?>  push({required String name ,dynamic argument}) async{
    _boolResultCompleter = Completer<Object?>();
    _pages.add(_createPage(RouteSettings(name:name,arguments:argument)));
    notifyListeners(); // 刷新
    return _boolResultCompleter.future;

  }


  MaterialPage _createPage(RouteSettings routeSettings){
    Widget page;
    switch(routeSettings.name) {
      case mainPage:
        page = const MyHomePage(title:"My home page");
        break;
      case secondPage:
       page = const SecondPage();
       break;
       default:
         page = const Scaffold();
    }
    return MaterialPage(child: page,key: Key(routeSettings.name!)as LocalKey,name: routeSettings.name,arguments: routeSettings.arguments);
  }


}