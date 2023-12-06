import 'package:ecom/models/productModel.dart';
import 'package:ecom/widgets/product_item_layout.dart';
import 'package:flutter/material.dart';

class PharmacyScreen extends StatefulWidget {
  List<Product> product;
  PharmacyScreen({super.key, required this.product});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  List<Product> pProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    for (Product i in widget.product) {
      if (i.category == "PHARMACY") {
        setState(() {
          pProduct.add(i);
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
          "PHARMACY",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [ProductLayout(product: pProduct)],
      ),
    );
  }
}
