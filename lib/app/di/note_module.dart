import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:todo_spacelab/app/core/note_entity/command/dispatcher.dart';
import 'package:todo_spacelab/app/core/note_entity/command/handler/create_handler.dart';
import 'package:todo_spacelab/app/core/note_entity/command/handler/delete_handler.dart';
import 'package:todo_spacelab/app/core/note_entity/query/dispatcher.dart';
import 'package:todo_spacelab/app/core/note_entity/query/handler/fetch_list_handler.dart';
import 'package:todo_spacelab/app/core/note_entity/repository/base_repository.dart';
import 'package:todo_spacelab/app/infrastructure/database/connection/base_connection.dart';
import 'package:todo_spacelab/app/infrastructure/database/note_repository.dart';
import 'package:todo_spacelab/app/viewmodel/note_viewmodel.dart';

class NoteModuleContainer {
  Injector init(Injector injector) {
    injector.map<BaseNoteRepository>((injector) => NoteSqlRepository(injector.get<DatabaseBaseConnection>()), isSingleton: true);

    injector.map<CreateNoteHandler>((injector) => CreateNoteHandler(injector.get<BaseNoteRepository>()), isSingleton: true);
    injector.map<DeleteNoteHandler>((injector) => DeleteNoteHandler(injector.get<BaseNoteRepository>()), isSingleton: true);
    injector.map<FetchListNoteHandler>((injector) => FetchListNoteHandler(injector.get<BaseNoteRepository>()), isSingleton: true);

    injector.map<NoteCommandDispatcher>((injector) => NoteCommandDispatcher(injector.get<CreateNoteHandler>(), injector.get<DeleteNoteHandler>()));

    injector.map<NoteQueryDispatcher>((injector) => NoteQueryDispatcher(injector.get<FetchListNoteHandler>()));

    injector.map<NoteViewModel>((injector) => NoteViewModel(injector.get<NoteCommandDispatcher>(), injector.get<NoteQueryDispatcher>()));

    return injector;
  }
}
