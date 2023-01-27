import 'package:todo_spacelab/app/core/common/base/query/base_handler.dart';
import 'package:todo_spacelab/app/core/common/model/note_readonly.dart';
import 'package:todo_spacelab/app/core/note_entity/query/fetch_list_query.dart';
import 'package:todo_spacelab/app/core/note_entity/repository/base_repository.dart';

class FetchListNoteHandler implements BaseQueryHandler<FetchNoteListQuery, List<NoteReadonlyModel>> {
  final BaseNoteRepository repository;

  FetchListNoteHandler(this.repository);

  @override
  Future<List<NoteReadonlyModel>> execute(FetchNoteListQuery query) async {
    return await repository.fetchList();
  }
}
