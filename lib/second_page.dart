import 'package:flutter/material.dart';
import 'package:wh/main.dart';


class SecondPage extends StatelessWidget {
  final String params;
  const SecondPage({super.key,this.params=''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: const Text('第二个页面'),
        onTap: () {
          print('SecondPage-Prams: $params');


          var result = 'ACK from secondPage 返回值';
          //todo
          router.popRoute(params: result);
        });
    throw UnimplementedError();
  }

}
