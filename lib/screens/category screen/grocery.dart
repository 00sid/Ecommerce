import 'package:ecom/models/productModel.dart';
import 'package:ecom/widgets/product_item_layout.dart';
import 'package:flutter/material.dart';

class GroceryScreen extends StatefulWidget {
  List<Product> product;
  GroceryScreen({super.key, required this.product});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  List<Product> gProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    for (Product i in widget.product) {
      if (i.category == "GROCERY") {
        setState(() {
          gProduct.add(i);
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GROCERY",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ProductLayout(product: gProduct),
        ],
      ),
    );
  }
}
