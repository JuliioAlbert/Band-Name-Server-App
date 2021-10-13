import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offLine, connecting }

class SocketRepository {
  ServerStatus _serverStatus = ServerStatus.connecting;
  final _socketResponse = StreamController<Map<String, dynamic>>();

  final _serverStream = StreamController<ServerStatus>();

  Stream<Map<String, dynamic>> get getSocket => _socketResponse.stream;

  void Function(Map<String, dynamic>) get addResponse =>
      _socketResponse.sink.add;

  ServerStatus get serverStatus => this._serverStatus;

  SocketRepository() {
    initConfig();
  }

  void initConfig() {
    // Dart client
  }
}
