import 'package:ecom/models/productModel.dart';
import 'package:ecom/widgets/product_item_layout.dart';
import 'package:flutter/material.dart';

class GarmentScreen extends StatefulWidget {
  List<Product> product;
  GarmentScreen({super.key, required this.product});

  @override
  State<GarmentScreen> createState() => _GarmentScreenState();
}

class _GarmentScreenState extends State<GarmentScreen> {
  List<Product> gProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    for (Product i in widget.product) {
      if (i.category == "GARMENT") {
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
        title: Text(
          "GARMENT",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [ProductLayout(product: gProduct)],
      ),
    );
  }
}
