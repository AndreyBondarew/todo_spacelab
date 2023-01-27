import 'package:todo_spacelab/app/core/common/base/command/command_exception.dart';
import 'package:todo_spacelab/app/core/note_entity/command/create_command.dart';
import 'package:todo_spacelab/app/core/note_entity/command/delete_command.dart';
import 'package:todo_spacelab/app/core/note_entity/command/handler/create_handler.dart';
import 'package:todo_spacelab/app/core/note_entity/command/handler/delete_handler.dart';

import '../../common/base/command/base_command.dart';
import '../../common/base/command/base_dispatcher.dart';

class NoteCommandDispatcher implements BaseCommandDispatcher {
  final CreateNoteHandler _createNoteHandler;
  final DeleteNoteHandler _deleteNoteHandler;

  NoteCommandDispatcher(this._createNoteHandler, this._deleteNoteHandler);

  @override
  Future<void> dispatch(BaseCommand command) async {
    bool commandIsExecute = false;
    if (command is CreateNoteCommand) {
      commandIsExecute = true;
      _createNoteHandler.execute(command);
    }
    if (command is DeleteNoteCommand) {
      commandIsExecute = true;
      _deleteNoteHandler.execute(command);
    }
    if (!commandIsExecute) {
      //тут, конечно, такое невозможно, но если существует несколько сущностей, то может быть передана команда не для текущей.
      throw InvalidCommandException(message: 'action for command not found!');
    }
  }
}
