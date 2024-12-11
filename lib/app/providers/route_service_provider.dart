import 'package:vania/vania.dart';
import 'package:apibackendyus/route/api_route.dart';
import 'package:apibackendyus/route/web.dart';
import 'package:apibackendyus/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    WebRoute().register();
    ApiRoute().register();
    WebSocketRoute().register();
  }
}
