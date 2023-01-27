class NoteReadonlyModel {
  final String id;
  final String name;

  //final String description;
  final bool isDone;

  NoteReadonlyModel({
    required this.id,
    required this.name,
    required this.isDone,
  });

  static NoteReadonlyModel fromMap(Map<String, dynamic> data) {
    return NoteReadonlyModel(
      id: data['id'].toString(),
      name: data['name'].toString(),
      isDone: data['is_done'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_done': isDone,
    };
  }
}
