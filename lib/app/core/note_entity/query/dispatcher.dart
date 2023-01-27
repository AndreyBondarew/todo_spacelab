import 'package:todo_spacelab/app/core/common/base/query/base_dispatcher.dart';
import 'package:todo_spacelab/app/core/common/base/query/base_query.dart';
import 'package:todo_spacelab/app/core/common/base/query/query_exception.dart';
import 'package:todo_spacelab/app/core/note_entity/query/fetch_list_query.dart';
import 'package:todo_spacelab/app/core/note_entity/query/handler/fetch_list_handler.dart';

class NoteQueryDispatcher implements BaseQueryDispatcher {
  final FetchListNoteHandler _fetchNoteListHandler;

  NoteQueryDispatcher(this._fetchNoteListHandler);

  @override
  Future<dynamic> dispatch(BaseQuery query) async {
    bool isExecute = false;
    if (query is FetchNoteListQuery) {
      isExecute = true;
      return await _fetchNoteListHandler.execute(query);
    }
    if (!isExecute) {
      throw InvalidQueryException(message: 'not found action for this query!');
    }
  }
}
