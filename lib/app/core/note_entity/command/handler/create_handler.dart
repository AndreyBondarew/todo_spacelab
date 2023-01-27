import 'package:todo_spacelab/app/core/note_entity/command/create_command.dart';
import 'package:todo_spacelab/app/core/note_entity/repository/base_repository.dart';

import '../../../common/base/command/base_handler.dart';

class CreateNoteHandler implements BaseCommandHandler<CreateNoteCommand> {
  final BaseNoteRepository noteRepository;

  CreateNoteHandler(this.noteRepository);

  @override
  Future<void> execute(CreateNoteCommand command) async {
    //NoteDomainModel note = NoteDomainModel(id: command.id, name: command.name, isDone: command.isDone);
    await noteRepository.save(command.noteDomainModel);
  }
}
