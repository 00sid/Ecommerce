import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/categoryModel.dart';
import 'package:ecom/models/productModel.dart';
import 'package:ecom/screens/home_screen.dart';
import 'package:ecom/screens/web_side/webwidgets/add_post_textfield.dart';
import 'package:ecom/utils/style.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/widgets/ecom_button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class SingleUpdateScreen extends StatefulWidget {
  static const String id = "singleupdateproduct";
  Product? product;
  SingleUpdateScreen({super.key, this.product});

  @override
  State<SingleUpdateScreen> createState() => _SingleUpdateScreenState();
}

class _SingleUpdateScreenState extends State<SingleUpdateScreen> {
  final TextEditingController productNameC = TextEditingController();
  final TextEditingController detailC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController discountPriceC = TextEditingController();
  final TextEditingController serialCodeC = TextEditingController();
  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourite = false;
  @override
  void dispose() {
    // TODO: implement dispose
    productNameC.dispose();
    detailC.dispose();
    priceC.dispose();
    discountPriceC.dispose();
    serialCodeC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedValue = widget.product!.category;
    priceC.text = widget.product!.price.toString();
    discountPriceC.text = widget.product!.discountPrice.toString();
    detailC.text = widget.product!.detail;
    serialCodeC.text = widget.product!.serialCode;
    productNameC.text = widget.product!.productName;
    isOnSale = widget.product!.isOnSale;
    isPopular = widget.product!.isPopular;
    isFavourite = widget.product!.isFavourite;

    super.initState();
  }

  String? selectedValue;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<dynamic> imageUrls = [];
  bool isSaving = false;
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "UPDATE PRODUCT",
                style: EcomStyle.kBoldStyle,
              ),
              dropDownButton(),
              const SizedBox(
                height: 10,
              ),
              TextFieldLayOut(
                discountPriceC: discountPriceC,
                detailC: detailC,
                priceC: priceC,
                productNameC: productNameC,
                serialCodeC: serialCodeC,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemCount: widget.product!.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: FancyShimmerImage(
                                imageUrl: widget.product!.imageUrls[index],
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  images.remove(images[index]);
                                });
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.black,
                              )),
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              EcomButton(
                child: "PICK IMAGES",
                ontap: () async {
                  await pickImage();
                },
                isOutlined: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Image.network(
                              File(images[index].path).path,
                              height: 300,
                              width: 300,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  images.remove(images[index]);
                                });
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.black,
                              )),
                        ],
                      );
                    }),
              ),
              SwitchListTile(
                  value: isOnSale,
                  title: const Text("Is this Product on Sale?"),
                  onChanged: (v) {
                    setState(() {
                      isOnSale = !isOnSale;
                    });
                  }),
              const SizedBox(
                height: 10,
              ),
              SwitchListTile(
                  value: isPopular,
                  title: const Text("Is this Product Popular?"),
                  onChanged: (v) {
                    setState(() {
                      isPopular = !isPopular;
                    });
                  }),
              const SizedBox(
                height: 10,
              ),
              EcomButton(
                loading: isSaving,
                child: "UPDATE",
                ontap: () async {
                  setState(() {
                    isSaving = true;
                  });
                  await updateItem(widget.product!.id);
                  setState(() {
                    isSaving = false;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownButton() {
    return Container(
      color: Colors.grey.withOpacity(0.3),
      child: DropdownButtonFormField(
          hint: const Text("Choose Category"),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null) {
              return "category mustbbe selected";
            }
            return null;
          },
          value: selectedValue,
          items: categories
              .map((e) =>
                  DropdownMenuItem(value: e.title, child: Text(e.title!)))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value.toString();
            });
          }),
    );
  }

  pickImage() async {
    final List<XFile> pickImage = await imagePicker.pickMultiImage();
    // ignore: unnecessary_null_comparison
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      return "No image selected";
    }
  }

  Future postImage(XFile? imageFile, String itemId) async {
    String url;
    final ref = FirebaseStorage.instance
        .ref()
        .child("images")
        .child(itemId)
        .child(imageFile!.name);
    if (kIsWeb) {
      await ref.putData(await imageFile.readAsBytes());
      SettableMetadata(contentType: "images/jpeg");
      url = await ref.getDownloadURL();
      return url;
    }
  }

  Future<void> uploadImages() async {
    for (var image in images) {
      await postImage(image, widget.product!.id)
          .then((value) => imageUrls.add(value));
    }
    imageUrls.add(widget.product!.imageUrls);
  }

  Future<void> updateItem(String itemId) async {
    final CollectionReference<Map<String, dynamic>> ref =
        FirebaseFirestore.instance.collection("products");
    await uploadImages();

    await ref.doc(itemId).update({
      "category": selectedValue,
      "detail": detailC.text,
      "discountPrice": discountPriceC.text,
      "isFavourite": isFavourite,
      "isOnSale": isOnSale,
      "price": priceC.text,
      "productName": productNameC.text,
      "serialCode": serialCodeC.text,
      "isPopular": isPopular,
      "imageUrls": imageUrls,
    }).whenComplete(() {
      showSnackBar("UPDATED SUCCEESSFULLY", context);
    });
  }

  clearFields() {
    priceC.clear();
    discountPriceC.clear();
    productNameC.clear();
    detailC.clear();
    serialCodeC.clear();
    isOnSale = false;
    isPopular = false;
  }
}
