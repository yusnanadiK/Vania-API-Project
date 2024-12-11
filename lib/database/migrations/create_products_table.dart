import 'package:vania/vania.dart';

class CreateProductsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('products', () {
      string('prod_id', length: 10);
      char('vend_id', length: 5);
      string('prod_name', length: 25);
      integer('prod_price');
      text('prod_desc');
      primary('prod_id');
      // Foreign key menggunakan method foreign()
      foreign(
        'vend_id',
        'vendors',
        'vend_id',
        onDelete: 'cascade',
      );
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('products');
  }
}
