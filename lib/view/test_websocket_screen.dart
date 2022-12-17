import 'dart:io';

import 'package:quicha/model/socket_methods.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:socket_io_client/socket_io_client.dart';

class TestWebSocketScreen extends HookWidget {


  @override
  Widget build(BuildContext context) {



    final _controller = useState(TextEditingController());
    final SocketMethods _socketMethods = SocketMethods();
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller.value,
                decoration: const InputDecoration(labelText: 'メッセージを送る'),
              ),
            ),
            ElevatedButton(onPressed: () {
              // _socketMethods.createRoom(_controller.value.text);
            }, child: Text("Button")),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
