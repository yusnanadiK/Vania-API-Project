import 'package:vania/vania.dart';

class CreateOrdersTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orders', () {
      integer('order_num', length: 11);
      date('order_date');
      char('cust_id', length: 5);
      primary('order_num');

      foreign(
        'cust_id',
        'customers',
        'cust_id',
        onDelete: 'cascade',
      );
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orders');
  }
}
