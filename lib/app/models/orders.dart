import 'package:vania/vania.dart';

class Orders extends Model {
  // Properti sesuai dengan kolom dalam tabel
  int? orderNum;
  DateTime? orderDate;
  String? custId;

  // Constructor
  Orders() {
    super.table('orders');
  }

  // Mengonversi dari Map ke objek Orders
  Orders.fromMap(Map<String, dynamic> map) {
    orderNum = map['order_num'];
    orderDate =
        map['order_date'] != null ? DateTime.parse(map['order_date']) : null;
    custId = map['cust_id'];
  }

  // Mengonversi dari objek Orders ke Map
  Map<String, dynamic> toMap() {
    return {
      'order_num': orderNum,
      'order_date': orderDate?.toIso8601String(),
      'cust_id': custId,
    };
  }
}
