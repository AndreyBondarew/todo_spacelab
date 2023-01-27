import 'package:todo_spacelab/app/core/common/base/command/base_command.dart';

class DeleteNoteCommand implements BaseCommand {
  final String id;

  DeleteNoteCommand({required this.id});
}
