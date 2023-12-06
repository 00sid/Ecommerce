import 'package:ecom/models/productModel.dart';
import 'package:ecom/widgets/product_item_layout.dart';
import 'package:flutter/material.dart';

class CosmeticsScreen extends StatefulWidget {
  List<Product> product;
  CosmeticsScreen({super.key, required this.product});

  @override
  State<CosmeticsScreen> createState() => _CosmeticsScreenState();
}

class _CosmeticsScreenState extends State<CosmeticsScreen> {
  List<Product> cProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    for (Product i in widget.product) {
      if (i.category == "COSMETICS") {
        setState(() {
          cProduct.add(i);
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
          "COSMETICS",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [ProductLayout(product: cProduct)],
      ),
    );
  }
}
