import 'package:app_scaffold/domain/bloc/socket/socket_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusText(),
          ],
        ),
      ),
      floatingActionButton: Button(),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socket = context.read<SocketBloc>().socket;
    return FloatingActionButton(
      onPressed: () {
        print('Emit');
        socket.emit(
            'nuevo-m', {'nombre': 'Flutter', 'mensaje': 'Hola desde Flutter'});
      },
    );
  }
}

class StatusText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(
      builder: (context, state) {
        return Text("Status ${state.status}");
      },
    );
  }
}
