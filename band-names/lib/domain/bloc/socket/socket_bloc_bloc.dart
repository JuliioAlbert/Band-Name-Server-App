import 'package:app_scaffold/domain/entities/band.dart';
import 'package:bloc/bloc.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:meta/meta.dart';

part 'socket_bloc_event.dart';
part 'socket_bloc_state.dart';

class SocketBloc extends Bloc<SocketBlocEvent, SocketState> {
  late IO.Socket _socket;
  SocketBloc() : super(SocketState()) {
    _socket = IO.io('http://192.168.0.8:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _socket.on('connect', (data) => add(Connect(ServerStatus.online)));
    _socket.on('disconnect', (data) => add(Connect(ServerStatus.offLine)));

    _socket.on('bandas-server', (payload) {
      final bandas = (payload as List).map((e) => Band.fromMap(e)).toList();
      add(LLenaLista(bandas));
    });

    on<SocketBlocEvent>(
      (event, emit) {
        if (event is Connect) {
          emit(state.copyWith(status: event.serverStatus));
        } else if (event is LLenaLista) {
          emit(state.copyWith(bandas: event.bandas));
        } else if (event is VoteBand) {
          socket.emit('vote-band', event.band);
        } else if (event is AddBand) {
          socket.emit('add-band', {'name': event.name});
        } else if (event is DeleteBand) {
          socket.emit('delete-band', event.band.toJson());
        }
      },
    );
  }

  IO.Socket get socket => _socket;

  @override
  Future<void> close() {
    _socket.dispose();
    print("SocketBloc");
    return super.close();
  }
}
