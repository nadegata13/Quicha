import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketClient {
  SocketClient();

   IO.Socket? socket;
   static SocketClient? _instance;

  SocketClient._internal(){
    //実機テスト用
    socket = IO.io("http://192.168.3.7:8080/", <String, dynamic>{
      'transports' : ["websocket"],
      'autoConnect' : false,
      'forceNew' : true,
    });
    // socket = IO.io("http://localhost:8080/", <String, dynamic>{
    //   'transports' : ["websocket"],
    //   'autoConnect' : false,
    //   'forceNew' : true,
    // });

    socket!.connect();
    socket!.onConnect((data) => print(data));

  }

  static SocketClient get instance {
    _instance ??=  SocketClient._internal();

    return _instance!;
  }
}

