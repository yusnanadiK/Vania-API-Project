import 'package:vania/vania.dart';

class CreateProductnotesTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('productnotes', () {
      char('note_id', length: 5);
      string('prod_id', length: 10);
      date('note_date');
      text('note_text');
      primary('note_id');
      // Foreign key menggunakan method foreign()
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
    await dropIfExists('productnotes');
  }
}
