import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  final IO.Socket _socket =
      IO.io('http://192.168.100.32:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    //_socket = IO.io('http://192.168.100.32:3000', <String, dynamic>{
    //'transports': ['websocket'],
    //'autoConnect': true,
    //});

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    //_socket.on('nuevo-mensaje', (payload) {
    //print('nuevo-mensaje:');
    //print('nombre:' + payload['nombre']);
    //print('mensaje:' + payload['mensaje']);
    //});
  }
}
