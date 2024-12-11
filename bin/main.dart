import 'dart:io';
import 'package:vania/vania.dart';
import 'package:apibackendyus/database/migrations/migrate.dart';

void main(List<String> args) async {
  // Inisialisasi koneksi database
  await MigrationConnection().setup();

  try {
    if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
      // Opsi untuk drop semua tabel dan migrasi ulang
      print("Melakukan migrasi ulang: drop semua tabel...");
      await Migrate().dropTables();
      print("Semua tabel berhasil di-drop.");
    }

    // Melakukan migrasi semua tabel
    print("Menjalankan migrasi semua tabel...");
    await Migrate().registry();
    print("Migrasi semua tabel selesai!");
  } catch (e) {
    print("Terjadi kesalahan saat migrasi: $e");
  } finally {
    // Menutup koneksi database
    await MigrationConnection().closeConnection();
    exit(0);
  }
}
