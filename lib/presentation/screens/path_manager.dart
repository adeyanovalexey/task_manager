import 'package:flutter/material.dart';

class PathManager{
  static void goPage(String path, BuildContext context, [Object? arg]){
      Navigator.of(context).pushNamed(path, arguments: arg);
  }
}