import 'package:flutter/material.dart';
import 'package:my_app/pages/form-edit.dart';
import 'package:my_app/pages/list-Item.dart';
import 'package:my_app/productModel.dart';

void main() => runApp(const MyApp());

// ...

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'OpenSans',
        backgroundColor: Colors.white,
      ),
      // MaterialApp contains our top-level Navigator
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => ListItemPage(),
        '/form': (BuildContext context) => FormEditPage(product: Product())
      },
    );
  }
}
