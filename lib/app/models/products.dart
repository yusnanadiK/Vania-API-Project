import 'package:vania/vania.dart';

class Products extends Model {
  // Properti sesuai dengan kolom dalam tabel
  String? prodId;
  String? vendId; // ID vendor yang terkait
  String? prodName;
  int? prodPrice;
  String? prodDesc;

  // Constructor
  Products() {
    super.table('products');
  }

  // Mengonversi dari Map ke objek Products
  Products.fromMap(Map<String, dynamic> map) {
    prodId = map['prod_id'];
    vendId = map['vend_id'];
    prodName = map['prod_name'];
    prodPrice = map['prod_price'];
    prodDesc = map['prod_desc'];
  }

  // Mengonversi dari objek Products ke Map
  Map<String, dynamic> toMap() {
    return {
      'prod_id': prodId,
      'vend_id': vendId,
      'prod_name': prodName,
      'prod_price': prodPrice,
      'prod_desc': prodDesc,
    };
  }
}
