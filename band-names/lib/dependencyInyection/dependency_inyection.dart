import 'package:app_scaffold/data/services/socket_repository.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInyection {
  static void init() {
    GetIt getIt = GetIt.instance;
    getIt.registerSingleton<SocketRepository>(SocketRepository());
  }
}
