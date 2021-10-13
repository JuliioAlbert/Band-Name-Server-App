part of 'socket_bloc_bloc.dart';

enum ServerStatus { online, offLine, connecting }

class SocketState {
  ServerStatus? status;
  List<Band>? bandas;

  SocketState({
    this.status = ServerStatus.offLine,
    this.bandas,
  });

  SocketState copyWith({
    ServerStatus? status,
    List<Band>? bandas,
  }) =>
      SocketState(
        status: status ?? this.status,
        bandas: bandas ?? this.bandas,
      );
}
