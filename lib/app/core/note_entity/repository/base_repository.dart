import 'package:todo_spacelab/app/core/common/model/note_readonly.dart';

import '../../common/model/note_domain.dart';

abstract class BaseNoteRepository {
  Future<void> save(NoteDomainModel note);

  Future<void> delete(String id);

  Future<List<NoteReadonlyModel>> fetchList();

  Future<NoteReadonlyModel?> getNoteFromId(String id);
}
