import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/productModel.dart';
import 'package:ecom/utils/style.dart';
import 'package:ecom/widgets/neo_container.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = "dashboard";
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Product> allProduct = [];
  List<String> imageUrls = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: Text(
            "ALL PRODUCTS",
            style: EcomStyle.kBoldStyle,
          ),
        ),
        Flexible(
          child: GridView.builder(
              itemCount: allProduct.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NeoContainer(
                    product: allProduct[index],
                  ),
                );
              }),
        ),
      ],
    ));
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot? snapshot) {
      setState(() {
        snapshot!.docs.forEach((e) {
          allProduct.add(
              Product.fromJson(e as DocumentSnapshot<Map<String, dynamic>>)!);
        });
        for (var i in allProduct) {
          for (var e in i.imageUrls) {
            imageUrls.add(e);
          }
        }
      });
    });
  }
}
