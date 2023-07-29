// page1.dart
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../main.dart';

// 把Page1组件改成一个StatefulWidget类的子类
class Page1 extends StatefulWidget {
  final BuildContext context;
  // 在构造函数中接受和赋值context参数
  Page1(this.context);
  @override
  _Page1State createState() => _Page1State();
}

// 定义一个_Page1State类，继承自State<Page1>
class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Page 1'),
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.all(20),
                child: Center(
                  child: ElevatedButton(
                    child: Text('Go to detail page'),
                    style: ButtonStyle(),
                    onPressed: () {
                      // 跳转到详情页之前，隐藏bottomNavigationBar
                      // 使用Provider.of来获取BottomNavigationBarModel类的实例，并调用它的方法来修改_showBottomNavigationBar的值
                      // Provider.of<BottomNavigationBarModel>(context, listen: false)
                      //     .setShowBottomNavigationBar(false);
                      // 在状态类中使用widget.context来获取传递过来的context，并在这个context中使用Navigator.pushNamed方法来跳转到'/detail'路由，并传递一个arguments属性作为参数

                      Navigator.pushNamed(
                        widget.context,
                        '/detail',
                        arguments: 'Hello',
                      ).then((value) => {
                            // 返回详情页之后，显示bottomNavigationBar
                            // 使用Provider.of来获取BottomNavigationBarModel类的实例，并调用它的方法来修改_showBottomNavigationBar的值
                            // Provider.of<BottomNavigationBarModel>(context, listen: false)
                            //     .setShowBottomNavigationBar(true)
                          });
                    },
                  ),
                )),
            ElevatedButton(
              child: Text('Go to communication'),
              onPressed: () {
                Navigator.pushNamed(
                  widget.context,
                  '/com',
                  // arguments: 'Hello',
                );
              },
            ),
          ],
        ));
  }
}
