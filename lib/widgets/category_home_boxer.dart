import 'package:ecom/models/categoryModel.dart';
import 'package:ecom/models/productModel.dart';
import 'package:ecom/screens/category%20screen/cosmetic.dart';
import 'package:ecom/screens/category%20screen/electronics.dart';
import 'package:ecom/screens/category%20screen/garment.dart';
import 'package:ecom/screens/category%20screen/grocery.dart';
import 'package:ecom/screens/category%20screen/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class CategoryHomeBoxes extends StatelessWidget {
  List<Product> product;

  CategoryHomeBoxes({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              categories.length,
              (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.7.w, vertical: 0.3.h),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (categories[index].title == "GROCERY") {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: GroceryScreen(product: product),
                                      type: PageTransitionType.fade));
                            } else if (categories[index].title ==
                                "ELECTRONICS") {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child:
                                          ElectronicsScreen(product: product),
                                      type: PageTransitionType.fade));
                            } else if (categories[index].title == "COSMETICS") {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: CosmeticsScreen(product: product),
                                      type: PageTransitionType.fade));
                            } else if (categories[index].title == "PHARMACY") {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: PharmacyScreen(product: product),
                                      type: PageTransitionType.fade));
                            } else if (categories[index].title == "GARMENT") {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: GarmentScreen(product: product),
                                      type: PageTransitionType.fade));
                            }
                          },
                          child: Container(
                            height: 9.h,
                            width: 13.w,
                            child: Container(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                ),
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(categories[index].image!),
                                ),
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          categories[index].title!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ))
        ],
      ),
    );
  }
}
