import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketClient {
  SocketClient();

   IO.Socket? socket;
   static SocketClient? _instance;

  SocketClient._internal(){
    socket = IO.io("http://localhost:3000/", <String, dynamic>{
      'transports' : ["websocket"],
      'autoConnect' : false,
      'forceNew' : true,
    });

    socket!.connect();
    socket!.onConnect((data) => print(data));

  }

  static SocketClient get instance {
    _instance ??=  SocketClient._internal();

    return _instance!;
  }
}

