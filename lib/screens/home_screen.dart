import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/services/auth_services.dart';
import 'package:ecom/utils/style.dart';
import 'package:ecom/widgets/alert_dialogue.dart';
import 'package:ecom/widgets/home_card.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List categories = [
  "GROCERY",
  "ELECTRONICS",
  "COSMETICS",
  "PHARMACY",
  "GARMENT",
];

class _HomeScreenState extends State<HomeScreen> {
  final AuthServices _authServices = AuthServices();

  final List images = [
    "https://media.istockphoto.com/id/1427555254/photo/halloween-table-old-wooden-plank-with-orange-pumpkin-in-purple-landscape-with-moonlight.jpg?s=1024x1024&w=is&k=20&c=N5fSjkehVVedXbUXPzqHgPbrDnTXR7xC4h5XRYh70zY=",
    "https://cdn.pixabay.com/photo/2012/12/27/19/41/halloween-72939_640.jpg",
    "https://cdn.pixabay.com/photo/2017/10/27/09/38/halloween-2893710_640.jpg",
    "https://cdn.pixabay.com/photo/2019/06/03/02/54/skull-4248008_640.jpg",
    "https://cdn.pixabay.com/photo/2019/10/27/22/15/halloween-4582988_640.jpg",
  ];
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Home Screen",
                  style: EcomStyle.kBoldStyle,
                ),
              ),
              CarouselSlider(
                items: images
                    .map((e) => Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: FancyShimmerImage(
                                imageUrl: e,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                color: Colors.black.withOpacity(0.6),
                                child: const Text(
                                  "TITLE",
                                  style: TextStyle(
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
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    HomeCard(title: categories[0]),
                    HomeCard(title: categories[1]),
                    HomeCard(title: categories[2]),
                    HomeCard(title: categories[3]),
                    HomeCard(title: categories[4]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDiaglueBox("Are you sure to log out ?", "Log out");
        },
        splashColor: Colors.red,
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          IconlyBold.lock,
        ),
      ),
    );
  }

  signOut() async {
    await _authServices.signOut();
  }
}
