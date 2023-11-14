import 'package:ecom/screens/web_side/screen/add_product_screen.dart';
import 'package:ecom/screens/web_side/screen/dashboard_screen.dart';
import 'package:ecom/screens/web_side/screen/delete_product_screen.dart';
import 'package:ecom/screens/web_side/screen/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class WebMain extends StatefulWidget {
  static const String id = "webMain";

  const WebMain({super.key});

  @override
  State<WebMain> createState() => _WebMainState();
}

class _WebMainState extends State<WebMain> {
  Widget selectedScreen = const DashboardScreen();
  chooseScreen(item) {
    switch (item) {
      case DashboardScreen.id:
        setState(() {
          selectedScreen = const DashboardScreen();
        });
        break;
      case AddProductScreen.id:
        setState(() {
          selectedScreen = const AddProductScreen();
        });
        break;
      case DeleteProductScreen.id:
        setState(() {
          selectedScreen = const DeleteProductScreen();
        });
        break;
      case UpdateProductScreen.id:
        setState(() {
          selectedScreen = const UpdateProductScreen();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: const Text("ADMIN"),
        backgroundColor: Colors.grey,
      ),
      sideBar: SideBar(
          backgroundColor: Colors.black.withOpacity(0.3),
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          onSelected: (item) {
            chooseScreen(item.route);
          },
          items: const [
            AdminMenuItem(
                title: "DASHBOARD",
                icon: Icons.dashboard,
                route: DashboardScreen.id),
            AdminMenuItem(
                title: "ADD PRODUCTS",
                icon: Icons.add,
                route: AddProductScreen.id),
            AdminMenuItem(
                title: "UPDATE PRODUCTS",
                icon: Icons.update,
                route: UpdateProductScreen.id),
            AdminMenuItem(
                title: "DELETE PRODUCTS",
                icon: IconlyBold.delete,
                route: DeleteProductScreen.id),
            AdminMenuItem(
              title: "CART ITEMS",
              icon: Icons.shop_2,
            ),
          ],
          selectedRoute: WebMain.id),
      body: selectedScreen,
    );
  }
}
