import 'package:vania/vania.dart';
import 'package:apibackendyus/app/models/productnotes.dart';

class ProductnotesController extends Controller {
  Future<Response> index() async {
    try {
      final productNotes = await Productnotes().query().get();
      return Response.json(productNotes);
    } catch (e) {
      return Response.json(400);
    }
  }

  Future<Response> create(Request request) async {
    try {
      final body = await request.body;

      // Validasi field yang diperlukan
      if (body['note_id'] == null ||
          body['prod_id'] == null ||
          body['note_text'] == null ||
          body['note_date'] == null) {
        return Response.json(
          {'error': 'Missing required fields'},
        );
      }

      // Validasi dan konversi note_date
      final noteDate = DateTime.tryParse(body['note_date']);
      if (noteDate == null) {
        return Response.json(
          {
            'error':
                'Invalid note_date format. Use YYYY-MM-DD or ISO 8601 format.'
          },
        );
      }

      // Buat instance Productnotes
      final productNote = Productnotes()
        ..noteId = body['note_id']
        ..prodId = body['prod_id']
        ..noteText = body['note_text']
        ..noteDate = noteDate;

      // Simpan ke database
      await productNote.query().insert({
        'note_id': productNote.noteId,
        'prod_id': productNote.prodId,
        'note_text': productNote.noteText,
        'note_date': productNote.noteDate!.toIso8601String(),
      });

      return Response.json({'success': true, 'data': productNote.toMap()});
    } catch (e) {
      print('Error in create: $e');
      return Response.json(
        {'error': 'Failed to create product note', 'details': e.toString()},
      );
    }
  }

  Future<Response> show(Request request, int id) async {
    try {
      final productNote =
          await Productnotes().query().where('note_id', '=', id).first();

      return Response.json({'success': true, 'data': productNote});
    } catch (e) {
      return Response.json({
        'error': 'Bad Request',
        'message': e.toString(),
      });
    }
  }

  Future<Response> update(Request request, int id) async {
    try {
      final body = await request.body;

      // Validasi field yang diperlukan
      if (body['note_id'] == null ||
          body['prod_id'] == null ||
          body['note_text'] == null ||
          body['note_date'] == null) {
        return Response.json(
          {'error': 'Missing required fields'},
        );
      }

      // Validasi dan konversi note_date
      final noteDate = DateTime.tryParse(body['note_date']);
      if (noteDate == null) {
        return Response.json(
          {
            'error':
                'Invalid note_date format. Use YYYY-MM-DD or ISO 8601 format.'
          },
        );
      }

      // Buat instance Productnotes
      final productNote = Productnotes()
        ..noteId = body['note_id']
        ..prodId = body['prod_id']
        ..noteText = body['note_text']
        ..noteDate = noteDate;

      // Update ke database
      final updated = await Productnotes()
          .query()
          .where('note_id', '=', productNote.noteId)
          .update({
        'prod_id': productNote.prodId,
        'note_text': productNote.noteText,
        'note_date':
            productNote.noteDate!.toIso8601String(), // Formatkan ke ISO 8601
      });

      if (updated == 0) {
        return Response.json({
          'error': 'Not Found',
          'message':
              'No product note found with note_id: ${productNote.noteId}',
        });
      }

      return Response.json({'success': true, 'data': productNote.toMap()});
    } catch (e, stackTrace) {
      // Tambahkan log error untuk debugging
      print('Error in update: $e');
      print(stackTrace);

      return Response.json(
          {'error': 'Failed to update product note', 'details': e.toString()});
    }
  }

  Future<Response> destroy(Request request, int id) async {
    try {
      final productNote =
          await Productnotes().query().where('note_id', '=', id).delete();

      if (productNote == 0) {
        return Response.json({
          'error': 'Not Found',
          'message': 'Product note with id $id not found',
        });
      }

      return Response.json({'message': 'Product note deleted successfully'});
    } catch (e) {
      return Response.json({
        'error': 'Bad Request',
        'message': e.toString(),
      });
    }
  }
}

final ProductnotesController productnotesController = ProductnotesController();
