import 'package:flutter/material.dart';
import '../pages/details.dart';
export 'index.dart' show getRouters;

Map<String, WidgetBuilder> getRouters(BuildContext context) {
  final Map<String, WidgetBuilder> routers = {
    //page1
    '/detail': (context) => DetailPage(),

    //page2...

    //page3...
  };
  return routers;
}
