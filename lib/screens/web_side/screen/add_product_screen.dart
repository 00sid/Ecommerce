import 'dart:io';

import 'package:ecom/models/productModel.dart';
import 'package:ecom/screens/home_screen.dart';
import 'package:ecom/screens/web_side/webwidgets/add_post_textfield.dart';
import 'package:ecom/utils/style.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/widgets/ecom_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  static const String id = "addproduct";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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

  String? selectedValue;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageUrls = [];
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
                "ADD PRODUCT",
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
                  color: Colors.grey.withOpacity(0.3),
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
              const SizedBox(
                height: 10,
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
                child: "UPLOAD PRODUCT",
                ontap: () async {
                  await upload();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  upload() async {
    String itemId = uuid.v4();
    setState(() {
      isSaving = true;
    });
    await uploadImages(itemId);
    await Product.addProducts(Product(
      category: selectedValue!,
      id: itemId,
      productName: productNameC.text,
      detail: detailC.text,
      price: int.parse(priceC.text),
      discountPrice: int.parse(discountPriceC.text),
      serialCode: serialCodeC.text,
      imageUrls: imageUrls,
      isOnSale: isOnSale,
      isPopular: isPopular,
      isFavourite: isFavourite,
    )).whenComplete(() {
      setState(() {
        isSaving = false;
        images.clear();
        imageUrls.clear();
        clearFields();
      });
      showSnackBar("uploaded successfully", context);
    });
    // await FirebaseFirestore.instance
    //     .collection("products")
    //     .add({"images": imageUrls}).whenComplete(() {
    //   setState(() {
    //     isSaving = false;
    //     images.clear();
    //     imageUrls.clear();
    //   });
    //   showSnackBar("uploaded successfully", context);
    // });
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
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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

  Future postImage(XFile? imageFile, String id) async {
    String url;
    final ref = FirebaseStorage.instance
        .ref()
        .child("images")
        .child(id)
        .child(imageFile!.name);
    if (kIsWeb) {
      await ref.putData(await imageFile.readAsBytes());
      SettableMetadata(contentType: "images/jpeg");
      url = await ref.getDownloadURL();
      return url;
    }
  }

  uploadImages(String id) async {
    for (var image in images) {
      await postImage(image, id).then((value) => imageUrls.add(value));
    }
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
