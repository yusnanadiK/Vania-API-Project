import 'package:vania/vania.dart';

class Productnotes extends Model {
  // Properti sesuai dengan kolom dalam tabel
  String? noteId; // ID catatan produk
  String? prodId; // ID produk yang terkait
  DateTime? noteDate; // Tanggal catatan
  String? noteText; // Teks catatan

  // Constructor
  Productnotes() {
    super.table('productnotes');
  }

  // Mengonversi dari Map ke objek Productnotes
  Productnotes.fromMap(Map<String, dynamic> map) {
    noteId = map['note_id'];
    prodId = map['prod_id'];
    noteDate =
        map['note_date'] != null ? DateTime.parse(map['note_date']) : null;
    noteText = map['note_text'];
  }

  // Mengonversi dari objek Productnotes ke Map
  Map<String, dynamic> toMap() {
    return {
      'note_id': noteId,
      'prod_id': prodId,
      'note_date':
          noteDate?.toIso8601String(), // Mengonversi DateTime ke String
      'note_text': noteText,
    };
  }
}
