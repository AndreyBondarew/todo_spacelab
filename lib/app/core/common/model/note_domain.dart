import 'package:uuid/uuid.dart';

class NoteDomainModel {
  final String id;
  final String name;

  //final String description;
  bool isDone;
  bool isNew;

  NoteDomainModel._({required this.id, required this.name, required this.isDone, required this.isNew});

  factory NoteDomainModel({String? id, required String name, bool isDone = false}) {
    bool isNew = false;
    if (id == null) {
      id = const Uuid().v4();
      isNew = true;
    }

    return NoteDomainModel._(
      id: id,
      name: name,
      isDone: isDone,
      isNew: isNew,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_done': isDone ? 1 : 0,
    };
  }

  factory NoteDomainModel.fromMap(Map<String, dynamic> data) {
    return NoteDomainModel(
      id: data['id'],
      name: data['name'],
      isDone: data['is_done'],
    );
  }
}
