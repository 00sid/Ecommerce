import 'package:ecom/widgets/ecom_text_field.dart';
import 'package:flutter/material.dart';

class TextFieldLayOut extends StatelessWidget {
  final TextEditingController productNameC;
  final TextEditingController detailC;
  final TextEditingController priceC;
  final TextEditingController discountPriceC;
  final TextEditingController serialCodeC;

  const TextFieldLayOut(
      {super.key,
      required this.discountPriceC,
      required this.detailC,
      required this.priceC,
      required this.productNameC,
      required this.serialCodeC});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EcomTextField(
          isEmail: false,
          isUsername: false,
          isBio: false,
          textEditingController: productNameC,
          hintText: "Enter product name..",
          isPass: false,
          textInputType: TextInputType.text,
          isOther: true,
        ),
        EcomTextField(
          isEmail: false,
          isUsername: false,
          isBio: false,
          textEditingController: detailC,
          hintText: "Enter product detail..",
          isPass: false,
          textInputType: TextInputType.text,
          isOther: true,
          isDetail: true,
        ),
        EcomTextField(
          isEmail: false,
          isUsername: false,
          isBio: false,
          textEditingController: priceC,
          hintText: "Enter product price..",
          isPass: false,
          textInputType: TextInputType.text,
          isOther: true,
        ),
        EcomTextField(
          isEmail: false,
          isUsername: false,
          isBio: false,
          textEditingController: discountPriceC,
          hintText: "Enter product discount price..",
          isPass: false,
          textInputType: TextInputType.text,
          isOther: true,
        ),
        EcomTextField(
          isEmail: false,
          isUsername: false,
          isBio: false,
          textEditingController: serialCodeC,
          hintText: "Enter product serial code",
          isPass: false,
          textInputType: TextInputType.text,
          isOther: true,
        ),
      ],
    );
  }
}
