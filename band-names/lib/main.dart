import 'package:app_scaffold/domain/bloc/socket/socket_bloc_bloc.dart';
import 'package:app_scaffold/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependencyInyection/dependency_inyection.dart';

void main() {
  DependencyInyection.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<SocketBloc>(create: (_) => SocketBloc()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: routes,
    );
  }
}
