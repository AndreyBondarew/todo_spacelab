import 'package:todo_spacelab/app/core/common/base/command/base_handler.dart';
import 'package:todo_spacelab/app/core/note_entity/command/delete_command.dart';
import 'package:todo_spacelab/app/core/note_entity/repository/base_repository.dart';

class DeleteNoteHandler implements BaseCommandHandler<DeleteNoteCommand> {
  final BaseNoteRepository noteRepository;

  DeleteNoteHandler(this.noteRepository);

  @override
  Future<void> execute(DeleteNoteCommand command) async {
    await noteRepository.delete(command.id);
  }
}
