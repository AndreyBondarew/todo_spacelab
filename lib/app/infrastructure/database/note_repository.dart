import 'package:todo_spacelab/app/core/common/model/note_domain.dart';
import 'package:todo_spacelab/app/core/common/model/note_readonly.dart';
import 'package:todo_spacelab/app/core/note_entity/repository/base_repository.dart';
import 'package:todo_spacelab/app/infrastructure/database/connection/base_connection.dart';

class NoteSqlRepository implements BaseNoteRepository {
  static const String table = 'notes';
  final DatabaseBaseConnection database;

  NoteSqlRepository(this.database);

  @override
  Future<void> delete(String id) async {
    await database.transaction((transaction) => transaction.delete(table, id));
  }

  @override
  Future<List<NoteReadonlyModel>> fetchList() async {
    List<NoteReadonlyModel> result = [];
    await database.transaction((transaction) async {
      List<Map<String, dynamic>> list = await transaction.select(table);
      for (var data in list) {
        result.add(NoteReadonlyModel.fromMap(data));
      }
    });
    return result;
  }

  @override
  Future<void> save(NoteDomainModel note) async {
    if (note.isNew) {
      await database.transaction((transaction) => transaction.insert(table, note.toMap()));
    } else {
      database.transaction((transaction) => transaction.update(table, note.toMap(), where: 'id = ?', whereArgs: [note.id]));
    }
  }

  @override
  Future<NoteReadonlyModel?> getNoteFromId(String id) async {
    NoteReadonlyModel? note;
    await database.transaction((transaction) async {
      List<Map<String, dynamic>> queryResult = await transaction.select(table, where: 'id = ?', whereArgs: [id]);
      if (queryResult.isNotEmpty) note = NoteReadonlyModel.fromMap(queryResult.first);
    });
    return note;
  }

  @override
  Future<void> updateStatus(String id, bool newStatus) async {
    await database.transaction((transaction) => transaction.update(table, {'is_done': newStatus ? 1 : 0}, where: 'id = ?', whereArgs: [id]));
  }
}
