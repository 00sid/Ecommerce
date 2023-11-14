import 'package:ecom/screens/layout_screen.dart';
import 'package:ecom/screens/web_side/screen/add_product_screen.dart';
import 'package:ecom/screens/web_side/screen/dashboard_screen.dart';
import 'package:ecom/screens/web_side/screen/delete_product_screen.dart';
import 'package:ecom/screens/web_side/screen/single_item_update_screen.dart';
import 'package:ecom/screens/web_side/screen/update_product_screen.dart';
import 'package:ecom/screens/web_side/web_login.dart';
import 'package:ecom/screens/web_side/web_main.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAvEb3kAyUWcSZD06HV23LkZ2KM4iaqOOY",
            authDomain: "ecom-f0ade.firebaseapp.com",
            projectId: "ecom-f0ade",
            storageBucket: "ecom-f0ade.appspot.com",
            messagingSenderId: "696166135470",
            appId: "1:696166135470:web:40ad4fffd230e11d309f3f"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecom',
        theme: ThemeData(
          textTheme: GoogleFonts.bioRhymeTextTheme(),
        ),
        home: const LayoutScreen(),
        routes: {
          WebLoginScreen.id: (context) => const WebLoginScreen(),
          WebMain.id: (context) => const WebMain(),
          DashboardScreen.id: (context) => const DashboardScreen(),
          DeleteProductScreen.id: (context) => const DeleteProductScreen(),
          UpdateProductScreen.id: (context) => const UpdateProductScreen(),
          AddProductScreen.id: (context) => const AddProductScreen(),
          SingleUpdateScreen.id: (context) => SingleUpdateScreen(),
        },
      ),
    );
  }
}
