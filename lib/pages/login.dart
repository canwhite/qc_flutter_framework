// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../main.dart';
// import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // 如果表单有效，调用自己的API来进行登录
                      try {
                        /** 
                        Dio dio = Dio();
                        Response response = await dio.post(
                          'https://example.com/api/login',
                          data: {
                            'email': _emailController.text,
                            'password': _passwordController.text,
                          },
                        );
                        // 如果登录成功，保存用户的token到本地存储，并跳转到主页
                        await saveToken(response.data['token']);
                        */
                        await saveToken("123");
                        // Provider.of<BottomNavigationBarModel>(context,
                        //         listen: false)
                        //     .setShowBottomNavigationBar(true);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                  title: 'Flutter Demo Home Page',
                                  context: context)),
                        );
                      } catch (e) {
                        // 如果出现错误，显示一个提示框
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Login failed'),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 16),
                /** 
                TextButton(
                  onPressed: () {
                    // 点击按钮跳转到注册页面
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text('Create an account'),
                ),
                */
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 定义一个方法来保存用户的token到本地存储
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
