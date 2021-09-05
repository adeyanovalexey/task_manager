import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget{
  static const String ROUTE_NAME = "no_connection_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Text('Подключение не выполнено'), alignment: Alignment.center));
  }
}