import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io('http://10.0.2.2:3000/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });

    this._socket.onConnect((_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.onDisconnect((_) {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    // socket.on('nuevo-mensaje', (payload) {
    //   print('nuevo-mensaje: ');
    //   print('nombre: ' + payload['nombre']);
    //   print('mensaje: ' + payload['mensaje']);
    //   print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay!');
    // });

    //-socket.connect();
  }
}
