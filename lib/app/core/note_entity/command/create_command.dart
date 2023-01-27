import 'package:todo_spacelab/app/core/common/base/command/base_command.dart';
import 'package:todo_spacelab/app/core/common/model/note_domain.dart';

class CreateNoteCommand implements BaseCommand {
  /*final String id;
  final String name;

  //final String description;
  final bool isDone;
  final bool isNew;*/

  NoteDomainModel noteDomainModel;

  CreateNoteCommand({
    /*required this.id,
    required this.name,
    required this.isDone,
    required this.isNew,*/
    required this.noteDomainModel,
  });

/*  factory CreateNoteCommand.fromModel(NoteDomainModel model) {
    return CreateNoteCommand(
      id: model.id,
      name: model.name,
      isDone: model.isDone,
      isNew: model.isNew,
    );
  }*/
}
