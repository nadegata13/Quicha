import 'package:flutter/material.dart';
import 'package:quicha/screen/chat_screen.dart';
import 'package:quicha/screen/home_screen.dart';
import 'package:quicha/screen/new_account_screen.dart';

import 'screen/first_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      title: 'Flutter Demo',
      home:   ChatScreen()
    );
  }
}


