import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:todo_spacelab/app/infrastructure/database/connection/base_connection.dart';
import 'package:todo_spacelab/app/infrastructure/database/connection/sqlite_connection.dart';

class CommonModuleContainer {
  Injector init(Injector injector) {
    injector.map<DatabaseBaseConnection>((i) => SQLiteDataBaseConnection(), isSingleton: true);
    return injector;
  }
}
