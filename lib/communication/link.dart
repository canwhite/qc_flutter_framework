import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Communication extends StatefulWidget {
  @override
  _Communication createState() => _Communication();
}

class _Communication extends State<Communication> {
  String _platformVersion = 'Unknown';
  int num = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  final _platformChannel =
      const MethodChannel("samples.flutter.dev/platform_channel");

  Future<void> initPlatformState() async {
    String platformVersion;
    //监听
    _platformChannel.setMethodCallHandler((call) async {
      print('Received platform call from Android: ${call.method}');
      if (call.method == "randomNumberGenerated") {
        int number = call.arguments;
        print('Callback received from Android with number $number');
        setState(() {
          num = number;
        });
      }
    });
    //触发和反馈
    platformVersion = await _platformChannel.invokeMethod('getPlatformVersion');
    //更新状态
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("communication"),
        ),
        body: Center(
          child: Text(_platformVersion + num.toString()),
        ));
  }
}
