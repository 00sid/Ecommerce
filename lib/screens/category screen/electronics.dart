import 'package:ecom/models/productModel.dart';
import 'package:ecom/widgets/product_item_layout.dart';
import 'package:flutter/material.dart';

class ElectronicsScreen extends StatefulWidget {
  List<Product> product;
  ElectronicsScreen({super.key, required this.product});

  @override
  State<ElectronicsScreen> createState() => _ElectronicsScreenState();
}

class _ElectronicsScreenState extends State<ElectronicsScreen> {
  List<Product> eProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    for (Product i in widget.product) {
      if (i.category == "ELECTRONICS") {
        setState(() {
          eProduct.add(i);
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ELECTRONICS",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [ProductLayout(product: eProduct)],
      ),
    );
  }
}
