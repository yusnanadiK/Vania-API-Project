import 'package:vania/vania.dart';

class CreateOrderitemsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orderitems', () {
      integer('order_item', length: 11);
      integer('order_num', length: 11);
      string('prod_id', length: 10);
      integer('quantity', length: 11);
      integer('size', length: 11);
      primary('order_item');
      // Foreign keys menggunakan method foreign()
      foreign(
        'order_num',
        'orders',
        'order_num',
        onDelete: 'cascade',
      );
      foreign(
        'prod_id',
        'products',
        'prod_id',
        onDelete: 'cascade',
      );
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orderitems');
  }
}
