import 'package:ecom/models/productModel.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class NeoContainer extends StatefulWidget {
  Product product;

  NeoContainer({
    super.key,
    required this.product,
  });

  @override
  State<NeoContainer> createState() => _NeoContainerState();
}

class _NeoContainerState extends State<NeoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 12.w,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          //darker shadow on bottom right
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(6, 6),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          //lighter shadow on top left
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-6, -6),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 10.h,
                  width: 22.w,
                  // child: Image.network("https://i.ibb.co/vwB46Yq/shoes.png"),
                  child: FancyShimmerImage(
                      imageUrl: widget.product.imageUrls[0],
                      boxFit: BoxFit.fill),
                ),
              ),
            ],
          ),
          Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Name: ",
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: widget.product.productName + "\n",
                        ),
                      ],
                    ),
                    TextSpan(
                      text: "Price: Rs ",
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: widget.product.price.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              const MouseRegion(
                cursor: SystemMouseCursors.click, // Change cursor on hover

                child: Text(
                  'View Details',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
