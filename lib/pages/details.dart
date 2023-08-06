// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
    return WebviewScaffold(
      /** 
      appBar: AppBar(
        title: Text('WebView'),
      ),
      */
      url: '$argument', // 设置要加载的网址
      withZoom: true, // 是否允许缩放，默认为true
      withLocalStorage: true, // 是否启用本地存储，默认为true
    );
  }
}
