import 'package:vania/vania.dart';

class Orderitems extends Model {
  // Properti sesuai dengan kolom dalam tabel
  int? orderItem; // ID unik untuk item pesanan
  int? orderNum; // Nomor pesanan yang terkait
  String? prodId; // ID produk yang dipesan
  int? quantity; // Jumlah produk yang dipesan
  int? size; // Ukuran produk (jika relevan)

  // Constructor
  Orderitems() {
    super.table('orderitems');
  }

  // Mengonversi dari Map ke objek Orderitems
  Orderitems.fromMap(Map<String, dynamic> map) {
    orderItem = map['order_item'];
    orderNum = map['order_num'];
    prodId = map['prod_id'];
    quantity = map['quantity'];
    size = map['size'];
  }

  // Mengonversi dari objek Orderitems ke Map
  Map<String, dynamic> toMap() {
    return {
      'order_item': orderItem,
      'order_num': orderNum,
      'prod_id': prodId,
      'quantity': quantity,
      'size': size,
    };
  }
}
