import 'package:vania/vania.dart';

class PersonalAccessTokens extends Model {
  // Properti sesuai dengan kolom dalam tabel
  int? id;
  String? name;
  int? tokenableId;
  String? token;
  DateTime? lastUsedAt;
  DateTime? createdAt;
  DateTime? deletedAt;

  // Constructor
  PersonalAccessTokens() {
    super.table('personal_access_tokens');
  }

  // Mengonversi dari Map ke objek PersonalAccessTokens
  PersonalAccessTokens.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    tokenableId = map['tokenable_id'];
    token = map['token'];
    lastUsedAt = map['last_used_at'] != null
        ? DateTime.parse(map['last_used_at'])
        : null;
    createdAt =
        map['created_at'] != null ? DateTime.parse(map['created_at']) : null;
    deletedAt =
        map['deleted_at'] != null ? DateTime.parse(map['deleted_at']) : null;
  }

  // Mengonversi dari objek PersonalAccessTokens ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tokenable_id': tokenableId,
      'token': token,
      'last_used_at': lastUsedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
