import 'package:flutter/material.dart';
import 'login_page.dart';
import 'produtos_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        LoginPage.tag: (context) => LoginPage(),
        ProdutosPage.tag: (context) => ProdutosPage()
      },
      initialRoute: LoginPage.tag,
    );
  }
}
