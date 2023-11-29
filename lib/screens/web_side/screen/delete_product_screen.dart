import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/services/database_services.dart';
import 'package:ecom/utils/style.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/widgets/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DeleteProductScreen extends StatefulWidget {
  static const String id = "deletescreen";
  const DeleteProductScreen({super.key});

  @override
  State<DeleteProductScreen> createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> {
  final DataBase _db = DataBase();
  void showRestoreDialogue(String text, String text2, String id) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogueBox(
            text: text,
            text2: text2,
            action: () async {
              await _db.deleteAndRestoreItem(id, "deletedItem", "products");
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              // ignore: use_build_context_synchronously
              showSnackBar("Restored Successfully", context);
            },
          );
        });
  }

  void showDeleteDiaglue(String text, String text2, String id) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogueBox(
            text: text,
            text2: text2,
            action: () async {
              await _db.deletePermanently(id);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              // ignore: use_build_context_synchronously
              showSnackBar("Deleted Permanently Successfully", context);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text(
              "DELETED PRODUCT",
              style: EcomStyle.kBoldStyle,
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("deletedItem")
                  .snapshots(),
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
                                          showRestoreDialogue(
                                              "Are you sure to restore?",
                                              "Restore",
                                              data[index]["id"]);
                                        },
                                        icon: const Icon(
                                          Icons.restore,
                                          color: Colors.green,
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          showDeleteDiaglue(
                                              "Are you sure to delete permanently?",
                                              "Delete",
                                              data[index]["id"]);
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
}
