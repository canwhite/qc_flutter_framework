// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final route = ModalRoute.of(context);
    // // 通过settings属性来获取传递的参数
    // final argument = route?.settings.arguments;
    final argument = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Text('This is the detail page$argument'),
      ),
    );
  }
}
