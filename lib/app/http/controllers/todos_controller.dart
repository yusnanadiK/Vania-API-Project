import 'package:vania/vania.dart';
import 'package:apibackendyus/app/models/todos.dart';

class TodoController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> store(Request request) async {
    request.validate({
      'title': 'required',
      'description': 'required',
    }, {
      'title.required': 'Judul todo wajib diisi',
      'description.required': 'Deskripsi todo wajib diisi',
    });

    Map<String, dynamic> data = request.all();

    Map<String, dynamic>? user = Auth().user();

    if (user != null) {
      var todo = await Todos().query().create({
        'user_id': Auth().id(),
        'title': data['title'],
        'description': data['description'],
      });

      return Response.json({
        'status': 'success',
        'message': 'Todo berhasil dibuat',
        'data': todo,
      }, 201);
    } else {
      return Response.json({
        'status': 'error',
        'message': 'Pengguna tidak terautentikasi',
      }, 401);
    }
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }
}

final TodoController todoController = TodoController();
