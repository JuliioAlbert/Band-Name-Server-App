part of 'socket_bloc_bloc.dart';

@immutable
abstract class SocketBlocEvent {}

class Connecting extends SocketBlocEvent {
  final ServerStatus serverStatus;

  Connecting(this.serverStatus);
}

class Connect extends SocketBlocEvent {
  final ServerStatus serverStatus;
  Connect(this.serverStatus);
}

class OffLine extends SocketBlocEvent {
  final ServerStatus serverStatus;
  OffLine(this.serverStatus);
}

class LLenaLista extends SocketBlocEvent {
  final List<Band> bandas;

  LLenaLista(this.bandas);
}

class VoteBand extends SocketBlocEvent {
  final Band band;

  VoteBand(this.band);
}

class AddBand extends SocketBlocEvent {
  final String name;

  AddBand(this.name);
}

class DeleteBand extends SocketBlocEvent {
  final Band band;

  DeleteBand(this.band);
}
