import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: const Text('第二个页面'),
        onTap: () {
          var result = 'ACK from secondPage 返回值';
          //todo
        });
    throw UnimplementedError();
  }

}
