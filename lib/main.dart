import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/Login.dart';

void main() {
  runApp(DATN());
}

class DATN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DATN',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
