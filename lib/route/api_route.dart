import 'package:vania/vania.dart';
import 'package:apibackendyus/app/http/controllers/customers_controller.dart';
import 'package:apibackendyus/app/http/controllers/orders_controller.dart';
import 'package:apibackendyus/app/http/controllers/vendors_controller.dart';
import 'package:apibackendyus/app/http/controllers/products_controller.dart';
import 'package:apibackendyus/app/http/controllers/orderitems_controller.dart';
import 'package:apibackendyus/app/http/controllers/productnotes_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix

    final customersController = CustomersController();
    final ordersController = OrdersController();
    final orderItemsController = OrderitemsController();
    final productsController = ProductController();
    final productNotesController = ProductnotesController();
    final vendorsController = VendorsController();

    /// Customers
    Router.get("/customers", customersController.index);
    Router.post("/customers", customersController.create);
    Router.get("/customers/{id}", customersController.show);
    Router.put("/customers/{id}", customersController.update);
    Router.delete("/customers/{id}", customersController.destroy);

    /// Orders
    Router.get("/orders", ordersController.index);
    Router.post("/orders", ordersController.create);
    Router.get("/orders/{id}", ordersController.show);
    Router.put("/orders/{id}", ordersController.update);
    Router.delete("/orders/{id}", ordersController.destroy);

    /// OrderItems
    Router.get("/orderitems", orderItemsController.index);
    Router.post("/orderitems", orderItemsController.create);
    Router.get("/orderitems/{id}", orderItemsController.show);
    Router.put("/orderitems/{id}", orderItemsController.update);
    Router.delete("/orderitems/{id}", orderItemsController.destroy);

    /// Products
    Router.get("/products", productsController.index);
    Router.post("/products", productsController.create);
    Router.get("/products/{id}", productsController.show);
    Router.put("/products/{id}", productsController.update);
    Router.delete("/products/{id}", productsController.destroy);

    /// ProductNotes
    Router.get("/productnotes", productNotesController.index);
    Router.post("/productnotes", productNotesController.create);
    Router.get("/productnotes/{id}", productNotesController.show);
    Router.put("/productnotes/{id}", productNotesController.update);
    Router.delete("/productnotes/{id}", productNotesController.destroy);

    /// Vendors
    Router.get("/vendors", vendorsController.index);
    Router.post("/vendors", vendorsController.create);
    Router.get("/vendors/{id}", vendorsController.show);
    Router.put("/vendors/{id}", vendorsController.update);
    Router.delete("/vendors/{id}", vendorsController.destroy);
  }
}
