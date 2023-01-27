import 'dart:async';

import 'package:todo_spacelab/app/core/note_entity/command/create_command.dart';
import 'package:todo_spacelab/app/core/note_entity/command/delete_command.dart';
import 'package:todo_spacelab/app/core/note_entity/command/dispatcher.dart';
import 'package:todo_spacelab/app/core/note_entity/query/dispatcher.dart';
import 'package:todo_spacelab/app/core/note_entity/query/fetch_list_query.dart';

import '../core/common/model/note_domain.dart';
import '../core/common/model/note_readonly.dart';

class NoteViewModel {
  final NoteCommandDispatcher noteCommandDispatcher;
  final NoteQueryDispatcher noteQueryDispatcher;
  late final StreamController<NoteListNotification> _eventController;

  Stream<NoteListNotification> get event => _eventController.stream;

  NoteViewModel(this.noteCommandDispatcher, this.noteQueryDispatcher) {
    _eventController = StreamController.broadcast();
  }

  Future<void> load() async {
    List<NoteReadonlyModel>? result = await noteQueryDispatcher.dispatch(FetchNoteListQuery());
    _eventController.add(NoteListResultNotification(result));
  }

  Future<void> delete(String id) async {
    await noteCommandDispatcher.dispatch(DeleteNoteCommand(id: id));
    _eventController.add(NoteListChangeNotification());
  }

  Future<void> save(NoteDomainModel note) async {
    await noteCommandDispatcher.dispatch(CreateNoteCommand(noteDomainModel: note));
  }

  void dispose() {
    _eventController.close();
  }
}

abstract class NoteListNotification {}

class NoteListResultNotification implements NoteListNotification {
  final List<NoteReadonlyModel>? noteList;

  NoteListResultNotification(this.noteList);
}

class NoteListChangeNotification implements NoteListNotification {}
