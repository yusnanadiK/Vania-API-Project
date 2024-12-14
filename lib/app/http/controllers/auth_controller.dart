import 'dart:io';

import 'package:vania/vania.dart';
import 'package:apibackendyus/app/models/user.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    request.validate({
      'name': 'required',
      'email': 'required|email',
      'password': 'required|min_length:6|confirmed',
    }, {
      'name.required': 'nama tidak boleh kosong',
      'email.required': 'email tidak boleh kosong',
      'email.email': 'email tidak valid',
      'password.required': 'password tidak boleh kosong',
      'password.min_length': 'password harus terdiri dari minimal 6 karakter',
      'password.confirmed': 'konfirmasi password tidak sesuai',
    });

    final name = request.input('name');
    final email = request.input('email');
    var password = request.input('password');

    var user = await User().query().where('email', '=', email).first();
    if (user != null) {
      return Response.json({
        "message": "user sudah ada",
      }, 409);
    }

    password = Hash().make(password);
    await User().query().insert({
      "name": name,
      "email": email,
      "password": password,
      "created_at": DateTime.now().toIso8601String(),
    });

    return Response.json({"message": "berhasil mendaftarkan user"}, 201);
  }

  Future<Response> login(Request request) async {
    request.validate({
      'email': 'required|email',
      'password': 'required',
    }, {
      'email.required': 'email tidak boleh kosong',
      'email.email': 'email tidak valid',
      'password.required': 'password tidak boleh kosong',
    });

    final email = request.input('email');
    var password = request.input('password').toString();

    var user = await User().query().where('email', '=', email).first();
    if (user == null) {
      return Response.json({
        "message": "user belum terdaftar",
      }, 409);
    }

    if (!Hash().verify(password, user['password'])) {
      return Response.json({
        "message": "kata sandi yang anda masukan salah",
      }, 401);
    }

    final token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(days: 30), withRefreshToken: true);

    return Response.json({
      "message": "berhasil login",
      "token": token,
    });
  }

  Future<Response> me() async {
    // Mendapatkan data pengguna dari token yang terautentikasi
    Map? user = Auth().user();

    // Cek apakah token valid dan data pengguna ditemukan
    if (user != null) {
      // Ambil ID atau email dari data token
      final email = user['email']; // Asumsi token menyimpan email pengguna

      // Query ke database untuk mengambil data lengkap pengguna
      var userData = await User().query().where('email', '=', email).first();

      if (userData != null) {
        // Hilangkan informasi sensitif seperti password
        userData.remove('password');

        // Tampilkan data lengkap pengguna, termasuk nama
        return Response.json({
          "message": "success",
          "data": {
            "name": userData['name'], // Nama pengguna
            "email": userData['email'],
          },
        }, HttpStatus.ok);
      }
    }

    // Jika token tidak valid atau pengguna tidak ditemukan
    return Response.json({
      "message": "Token tidak valid atau pengguna tidak ditemukan",
    }, HttpStatus.unauthorized);
  }
}

final AuthController authController = AuthController();
