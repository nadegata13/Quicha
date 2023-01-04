import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TimerState();
  }
}

class _TimerState extends State<TimerPage> {
  String _nowtime = '';
  var formatter = DateFormat('yyyy/MM/dd HH:mm:ss');
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      // 定期実行する間隔の設定.
      const Duration(seconds: 1),
      // 定期実行関数.
      _onTimer,
    );

    print(_timer.isActive);
  }

  @override
  void dispose(){
    // 破棄される時に停止する.
    _timer.cancel();
    super.dispose();
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    var formatterTime = formatter.format(now);
    setState(() {
      _nowtime = formatterTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TimerPage')),
      body:Text('現在時刻：\n$_nowtime' ),



    );
  }
}