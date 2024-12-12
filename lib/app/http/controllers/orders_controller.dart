import 'package:vania/vania.dart';
import 'package:apibackendyus/app/models/orders.dart';

class OrdersController extends Controller {
  Future<Response> index() async {
    try {
      final orders = await Orders().query().get();
      return Response.json(orders);
    } catch (e) {
      return Response.json(400);
    }
  }

  Future<Response> create(Request request) async {
    try {
      final body = await request.body;

      // Validasi field yang diperlukan
      if (body['order_num'] == null ||
          body['cust_id'] == null ||
          body['order_date'] == null) {
        return Response.json(
          {'error': 'Missing required fields'},
        );
      }

      // Konversi order_date ke DateTime
      final orderDate = DateTime.tryParse(body['order_date']);
      if (orderDate == null) {
        return Response.json(
          {
            'error':
                'Invalid order_date format. Use YYYY-MM-DD or ISO 8601 format.'
          },
        );
      }

      // Buat instance Order
      final order = Orders()
        ..orderNum = body['order_num']
        ..custId = body['cust_id']
        ..orderDate = orderDate;

      // Simpan ke database
      await order.query().insert({
        'order_num': order.orderNum,
        'cust_id': order.custId,
        'order_date':
            order.orderDate!.toIso8601String(), // Gunakan operator `!` di sini
      });

      return Response.json({'success': true, 'data': order.toMap()});
    } catch (e) {
      print('Error in create: $e');
      return Response.json(
        {'error': 'Failed to create order', 'details': e.toString()},
      );
    }
  }

  Future<Response> show(Request request, int id) async {
    try {
      final order = await Orders().query().where('order_num', '=', id).first();

      return Response.json({'success': true, 'data': order});
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

      // Validasi order_date dan konversi ke DateTime
      final orderDate = DateTime.tryParse(body['order_date']);
      if (orderDate == null) {
        return Response.json(
          {
            'error':
                'Invalid order_date format. Use YYYY-MM-DD or ISO 8601 format.'
          },
        );
      }

      // Buat instance Order dengan data yang diupdate
      final order = Orders()
        ..orderNum = body['order_num']
        ..custId = body['cust_id']
        ..orderDate = orderDate;

      // Update data dalam database
      final affectedRows = await Orders()
          .query()
          .where('order_num', '=', order.orderNum)
          .update({
        'cust_id': order.custId,
        'order_date':
            order.orderDate!.toIso8601String(), // Konversi ke string ISO 8601
      });

      if (affectedRows == 0) {
        return Response.json(
          {
            'error': 'Not Found',
            'message': 'No order found with the specified order_num'
          },
        );
      }

      return Response.json({'success': true, 'data': order.toMap()});
    } catch (e) {
      print('Error in update: $e');
      return Response.json({'error': 'Bad Request', 'message': e.toString()});
    }
  }

  Future<Response> destroy(Request request, int id) async {
    try {
      final order = await Orders().query().where('order_num', '=', id).delete();

      if (order == 0) {
        return Response.json({
          'error': 'Not Found',
          'message': 'Order with id $id not found',
        });
      }

      return Response.json({'message': 'Order deleted successfully'});
    } catch (e) {
      return Response.json({
        'error': 'Bad Request',
        'message': e.toString(),
      });
    }
  }
}

final OrdersController ordersController = OrdersController();
