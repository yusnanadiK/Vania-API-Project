import 'dart:ffi';

import 'package:vania/vania.dart';

class Vendors extends Model {
  // Properti sesuai dengan kolom dalam tabel
  Char? vendId;
  String? vendName;
  String? vendAddress;
  String? vendKota;
  String? vendState;
  String? vendZip;
  String? vendCountry;

  // Constructor
  Vendors() {
    super.table('vendors');
  }

  // Mengonversi dari Map ke objek Vendors
  Vendors.fromMap(Map<String, dynamic> map) {
    vendId = map['vend_id'];
    vendName = map['vend_name'];
    vendAddress = map['vend_address'];
    vendKota = map['vend_kota'];
    vendState = map['vend_state'];
    vendZip = map['vend_zip'];
    vendCountry = map['vend_country'];
  }

  // Mengonversi dari objek Vendors ke Map
  Map<String, dynamic> toMap() {
    return {
      'vend_id': vendId,
      'vend_name': vendName,
      'vend_address': vendAddress,
      'vend_kota': vendKota,
      'vend_state': vendState,
      'vend_zip': vendZip,
      'vend_country': vendCountry,
    };
  }
}
