// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './login.dart';
// import 'package:provider/provider.dart';
// import '../main.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page3"),
      ),
      body: Center(
        child: IconButton(
          onPressed: () async {
            // 点击按钮退出登录，并删除本地存储的token和邮箱
            await deleteToken();
            // await deleteEmail();
            // 跳转到登录页面
            // Provider.of<BottomNavigationBarModel>(context, listen: false)
            //     .setShowBottomNavigationBar(false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          icon: Icon(Icons.logout),
        ),
      ),
    );
  }

  // 定义一个方法来删除本地存储的token
  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // 定义一个方法来删除本地存储的邮箱
  // Future<void> deleteEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('email');
  // }
}
