import 'package:ecom/models/productModel.dart';
import 'package:ecom/screens/product_detail_screen.dart';
import 'package:ecom/widgets/neo_container.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ProductLayout extends StatelessWidget {
  List<Product> product;
  ProductLayout({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: product.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: ProductDetailScreen(product: product[index]),
                    type: PageTransitionType.fade,
                  ),
                );
              },
              child: NeoContainer(
                product: product[index],
              ),
            ),
          );
        });
  }
}
