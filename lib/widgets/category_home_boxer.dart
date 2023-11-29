import 'package:ecom/models/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryHomeBoxes extends StatelessWidget {
  const CategoryHomeBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              categories.length,
              (index) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          width: 14.w,
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
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          categories[index].title!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
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
