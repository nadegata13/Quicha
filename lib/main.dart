import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/view/chat_screen/chat_screen.dart';
import 'package:quicha/view/chat_screen/widget/app_bar.dart';
import 'package:quicha/view/create_new_account_screen/new_account_screen.dart';
import 'package:quicha/view/home_screen/home_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      title: 'Flutter Demo',
      home:   MyHomePage()
    );
  }
}


