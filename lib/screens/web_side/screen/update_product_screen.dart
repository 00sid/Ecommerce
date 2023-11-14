import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/productModel.dart';
import 'package:ecom/screens/web_side/screen/single_item_update_screen.dart';
import 'package:ecom/utils/style.dart';
import 'package:ecom/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class UpdateProductScreen extends StatelessWidget {
  static const String id = "updatescreen";
  const UpdateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text(
              "UPDATE PRODUCT",
              style: EcomStyle.kBoldStyle,
            ),
          ),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.grey,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No data"),
                  );
                }
                final data = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.grey.withOpacity(0.5),
                            child: ListTile(
                              title: Text(data[index]["productName"]),
                              subtitle: Text(data[index]["category"]),
                              trailing: SizedBox(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: SingleUpdateScreen(
                                                      //  uid: data[index]["id"],
                                                      product: Product.fromJson(
                                                    data[index],
                                                  )),
                                                  type:
                                                      PageTransitionType.fade));
                                        },
                                        icon: const Icon(
                                          IconlyBold.edit,
                                          color: Colors.green,
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await deleteItem(data[index]["id"]);
                                          showSnackBar(
                                              "Deleted Successfully", context);
                                        },
                                        icon: const Icon(
                                          IconlyBold.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }

  deleteItem(String id) async {
    final sourceRef = FirebaseFirestore.instance.collection("products");
    final destiRef = FirebaseFirestore.instance.collection("deletedItem");
    try {
      DocumentSnapshot snapshot = await sourceRef.doc(id).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        await destiRef.doc(id).set(data);
      } else {
        print("Document doesnot exist");
      }
      sourceRef.doc(id).delete();
    } catch (e) {}
  }
}
