import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:todo_spacelab/app/di/common.dart';
import 'package:todo_spacelab/app/di/note_module.dart';

class DI {
  void init() {
    final Injector injector = Injector();

    CommonModuleContainer().init(injector);
    NoteModuleContainer().init(injector);
  }
}
