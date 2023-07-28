// main.dart
// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/page1.dart';
import './pages/page2.dart';
import './pages/page3.dart';
import './pages/details.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';
import './pages/login.dart';

/**
Provider的使用
1）
* 在main里，你使用了ChangeNotifierProvider来提供一个BottomNavigationBarModel类的实例，
它是一个ChangeNotifier类的子类，用来存储和更新_showBottomNavigationBar的值。
2）
*在main里，你使用了Consumer来监听BottomNavigationBarModel类的变化，
并根据_showBottomNavigationBar的值来决定是否显示bottomNavigationBar。
3）
*在详情页里，你使用了Provider.of来获取BottomNavigationBarModel类的实例，并在跳转到详情页之前和返回详情页之后，调用它的方法来修改_showBottomNavigationBar的值。这样就会触发BottomNavigationBarModel类的notifyListeners方法，通知所有监听者更新状态。
 
然后page1触发，main消费
*/

// 定义一个BottomNavigationBarModel类，继承自ChangeNotifier
class BottomNavigationBarModel extends ChangeNotifier {
  // 定义一个_showBottomNavigationBar属性，初始值为true
  bool _showBottomNavigationBar = true;

  // 定义一个getter方法，用来获取_showBottomNavigationBar的值
  bool get showBottomNavigationBar => _showBottomNavigationBar;

  // 定义一个方法，用来修改_showBottomNavigationBar的值，并通知监听者
  void setShowBottomNavigationBar(bool value) {
    _showBottomNavigationBar = value;
    notifyListeners();
  }
}

void main() {
  //初始化
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // 使用ChangeNotifierProvider来包裹MyApp组件，提供一个BottomNavigationBarModel类的实例
    ChangeNotifierProvider(
      create: (context) => BottomNavigationBarModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //定义一个方法来获取本地token
    // 定义一个方法来获取本地存储的token
    Future<String?> getToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 使用Builder组件来创建一个新的context
      // home: Builder(
      //   builder: (context) =>MyHomePage(title: 'Flutter Demo Home Page', context: context)
      // ),
      // 使用FutureBuilder组件来根据本地存储的用户信息显示不同的页面
      home: FutureBuilder<String?>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 如果有token，说明已经登录，显示主页
            return MyHomePage(
                title: 'Flutter Demo Home Page', context: context);
          } else {
            // 如果没有token，说明没有登录，显示登录页面
            return LoginPage();
          }
        },
      ),

      // 提供一个routes属性，定义不同的路由名称和对应的页面组件
      routes: {
        '/detail': (context) => DetailPage(),
      },
    );
  }
}

//MyHomePage
class MyHomePage extends StatefulWidget {
// 1）const MyHomePage：这是声明了一个常量的构造函数，它表示MyHomePage类的实例在编译时就确定了，不会在运行时改变。
// 2） ({Key? key, required this.title})：这是使用了命名参数的语法，它表示构造函数的参数可以按照任意顺序传递，并且可以省略一些可选的参数。Key? key表示一个可选的参数，它是一个Key类型的值，
// 用来标识widget在widget树中的位置。required this.title表示一个必须的参数，它是一个String类型的值，用来存储页面的标题，并且赋值给MyHomePage类的title属性。
// : super(key: key)：这是调用了父类的构造函数，也就是StatefulWidget类的构造函数，并把key参数传递给它。
  const MyHomePage({Key? key, required this.title, required this.context})
      : super(key: key);
  //final和const的区别是它可以在runtime的时候赋值，一旦赋值不能改变
  final String title;
  // 定义一个context属性，用来存储传递过来的context
  final BuildContext context;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//MyHomePage的状态类
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };
// 把_widgetOptions属性的初始化放在构造函数中
  late final List<Widget> _widgetOptions;

  //widget的生命钩子
  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[Page1(widget.context), Page2(), Page3()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      // 使用Consumer来监听BottomNavigationBarModel类的变化，并根据_showBottomNavigationBar的值来决定是否显示bottomNavigationBar
      bottomNavigationBar:
          Consumer<BottomNavigationBarModel>(builder: (context, model, child) {
        return model.showBottomNavigationBar
            ? BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Business',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'School',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              )
            // 返回一个空的Widget
            : SizedBox();
      }),

      body: _widgetOptions.elementAt(_selectedIndex), // 直接显示对应的页面
    );
  }
}
