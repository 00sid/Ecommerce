import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/productModel.dart';
import 'package:ecom/screens/product_detail_screen.dart';
import 'package:ecom/services/auth_services.dart';
import 'package:ecom/widgets/alert_dialogue.dart';
import 'package:ecom/widgets/category_home_boxer.dart';
import 'package:ecom/widgets/neo_container.dart';
import 'package:ecom/widgets/product_item_layout.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// List categories = [
//   "GROCERY",
//   "ELECTRONICS",
//   "COSMETICS",
//   "PHARMACY",
//   "GARMENT",
// ];

class _HomeScreenState extends State<HomeScreen> {
  final AuthServices _authServices = AuthServices();
  // final DataBase _db = DataBase();

  final List images = [
    "https://media.istockphoto.com/id/1427555254/photo/halloween-table-old-wooden-plank-with-orange-pumpkin-in-purple-landscape-with-moonlight.jpg?s=1024x1024&w=is&k=20&c=N5fSjkehVVedXbUXPzqHgPbrDnTXR7xC4h5XRYh70zY=",
    "https://cdn.pixabay.com/photo/2012/12/27/19/41/halloween-72939_640.jpg",
    "https://cdn.pixabay.com/photo/2017/10/27/09/38/halloween-2893710_640.jpg",
    "https://cdn.pixabay.com/photo/2019/06/03/02/54/skull-4248008_640.jpg",
    "https://cdn.pixabay.com/photo/2019/10/27/22/15/halloween-4582988_640.jpg",
  ];
  List<Product> allProduct = [];
  List<String> onSaleimageUrls = [];
  List<Product> onSaleProducts = [];
  List<Product> groceryProducts = [];
  List<Product> electronicsProducts = [];
  List<Product> garmentProducts = [];
  List<Product> pharmacyProducts = [];
  List<Product> cosmeticsProducts = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void showDiaglueBox(
    String text,
    String text2,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogueBox(
            text: text,
            text2: text2,
            action: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await refreshHandle();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "ECOM",
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "  BUY",
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CategoryHomeBoxes(
                        product: allProduct,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "ON SALE PRODUCTS",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SliderImages(product: onSaleProducts),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("ALL PRODUCTS"),
                      ProductLayout(product: allProduct),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signOut() async {
    await _authServices.signOut();
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
          // for (var e in i.imageUrls) {
          //   imageUrls.add(e);
          // }
          if (i.isOnSale == true) {
            onSaleProducts.add(i);
          } else if (i.category == "GROCERY") {
            groceryProducts.add(i);
          } else if (i.category == "ELECTRONICS") {
            electronicsProducts.add(i);
            print("Nepal");
          } else if (i.category == "GARMENT") {
            garmentProducts.add(i);
          } else if (i.category == "PHARMACY") {
            pharmacyProducts.add(i);
          }
        }
      });
    });
  }

  Future<void> refreshHandle() async {
    setState(() {
      allProduct = [];
      onSaleProducts = [];
    });
    await getData();
  }
  // getData() async {
  //   final snap = await _db.fetchData();
  //   final List data = snap!.map(
  //       (e) => {Product.fromJson(e as DocumentSnapshot<Map<String, dynamic>>)}).toList();
  //   setState(() {
  //     allProduct = data;
  //   });
  // }
}

class SliderImages extends StatelessWidget {
  const SliderImages({super.key, required this.product});

  final List<Product> product;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: product
          .map((e) => Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FancyShimmerImage(
                      imageUrl: e.imageUrls[1],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      child: Text(
                        e.productName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ))
          .toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
  }
}
