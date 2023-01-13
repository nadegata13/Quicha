import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/view/chat_screen/chat_screen.dart';
import 'package:quicha/view/chat_screen/widget/app_bar.dart';
import 'package:quicha/view/create_new_account_screen/new_account_screen.dart';
import 'package:quicha/view/home_screen/home_screen.dart';
import 'package:quicha/view/login_or_sign_up_screen/login_or_sign_up_screen.dart';
import 'package:quicha/view/testTimerScreen.dart';
import 'package:quicha/view/test_websocket_screen.dart';

import 'repository/socket_client.dart';

void main() async {



  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return
      MaterialApp(
      title: 'Flutter Demo',
      home:  ChatScreen(),
       debugShowCheckedModeBanner: false,
    );
  }
}


