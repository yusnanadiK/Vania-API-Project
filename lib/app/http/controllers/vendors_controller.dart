import 'package:vania/vania.dart';
import 'package:apibackendyus/app/models/vendors.dart';

class VendorsController extends Controller {
  Future<Response> index() async {
    try {
      final vendors = await Vendors().query().get();
      return Response.json(vendors);
    } catch (e) {
      return Response.json(400);
    }
  }

  Future<Response> create(Request request) async {
    try {
      final body = await request.body;

      if (body['vend_id'] == null ||
          body['vend_name'] == null ||
          body['vend_address'] == null ||
          body['vend_kota'] == null ||
          body['vend_state'] == null ||
          body['vend_zip'] == null ||
          body['vend_country'] == null) {
        return Response.json(
          {'error': 'Missing required fields'},
        );
      }

      final vendor = Vendors()
        ..vendId = body['vend_id']
        ..vendName = body['vend_name']
        ..vendAddress = body['vend_address']
        ..vendKota = body['vend_kota']
        ..vendState = body['vend_state']
        ..vendZip = body['vend_zip']
        ..vendCountry = body['vend_country'];

      await vendor.query().insert({
        'vend_id': vendor.vendId,
        'vend_name': vendor.vendName,
        'vend_address': vendor.vendAddress,
        'vend_kota': vendor.vendKota,
        'vend_state': vendor.vendState,
        'vend_zip': vendor.vendZip,
        'vend_country': vendor.vendCountry,
      });
      return Response.json({'success': true, 'data': vendor.toMap()});
    } catch (e) {
      print('Error in store: $e');
      return Response.json(
        {'error': 'Failed to create vendor', 'details': e.toString()},
      );
    }
  }

  Future<Response> show(Request request, int id) async {
    try {
      final vendor = await Vendors().query().where('vend_id', '=', id).first();

      return Response.json({'success': true, 'data': vendor});
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

      final vendor = Vendors()
        ..vendId = body['vend_id']
        ..vendName = body['vend_name']
        ..vendAddress = body['vend_address']
        ..vendKota = body['vend_kota']
        ..vendState = body['vend_state']
        ..vendZip = body['vend_zip']
        ..vendCountry = body['vend_country'];

      await Vendors().query().where('vend_id', '=', vendor.vendId).update({
        'vend_name': vendor.vendName,
        'vend_address': vendor.vendAddress,
        'vend_kota': vendor.vendKota,
        'vend_state': vendor.vendState,
        'vend_zip': vendor.vendZip,
        'vend_country': vendor.vendCountry,
      });

      return Response.json({'success': true, 'data': vendor.toMap()});
    } catch (e) {
      return Response.json({'error': 'Bad Request', 'message': e.toString()});
    }
  }

  Future<Response> destroy(Request request, int id) async {
    try {
      final vendor = await Vendors().query().where('vend_id', '=', id).delete();

      if (vendor == 0) {
        return Response.json({
          'error': 'Not Found',
          'message': 'Vendor with id $id not found',
        });
      }

      return Response.json({'message': 'Vendor deleted successfully'});
    } catch (e) {
      return Response.json({
        'error': 'Bad Request',
        'message': e.toString(),
      });
    }
  }
}

final VendorsController vendorsController = VendorsController();
