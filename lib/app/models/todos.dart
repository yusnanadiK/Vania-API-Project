import 'package:vania/vania.dart';

class Todos extends Model {
  // Properti sesuai dengan kolom dalam tabel
  int? id;
  int? userId;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Constructor
  Todos() {
    super.table('todos');
  }

  // Mengonversi dari Map ke objek Todos
  Todos.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['user_id'];
    title = map['title'];
    description = map['description'];
    createdAt =
        map['created_at'] != null ? DateTime.parse(map['created_at']) : null;
    updatedAt =
        map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null;
  }

  // Mengonversi dari objek Todos ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
