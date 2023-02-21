import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  SocketClient();

  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = IO.io("http://133.242.187.239:8080/", <String, dynamic>{
      'transports': ["websocket"],
      'autoConnecmat': false,
      'forceNew': true,
    });
// ifconfig |grep broadcast

    // socket = IO.io("http://192.168.3.16:8080/", <String, dynamic>{
    //   'transports': ["websocket"],
    //   'autoConnect': false,
    //   'forceNew': true,
    // });

    socket!.connect();
    socket!.onConnect((data) => print(data));
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();

    return _instance!;
  }
}
