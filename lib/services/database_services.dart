import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/utils/utils.dart';

class DataBase {
  Future<void> deleteAndRestoreItem(
      String id, String source, String desti) async {
    final sourceRef = FirebaseFirestore.instance.collection(source);
    final destiRef = FirebaseFirestore.instance.collection(desti);
    try {
      DocumentSnapshot snapshot = await sourceRef.doc(id).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        await destiRef.doc(id).set(data);
      } else {
        print("Document doesnot exist");
      }
      sourceRef.doc(id).delete();
    } catch (e) {
      toastMessage(e.toString());
    }
  }

  Future<void> deletePermanently(String id) async {
    final ref = FirebaseFirestore.instance.collection("deletedItem");
    try {
      DocumentSnapshot snapshot = await ref.doc(id).get();
      if (snapshot.exists) {
        ref.doc(id).delete();
      } else {
        toastMessage("Document not found");
      }
    } catch (e) {
      toastMessage(e.toString());
    }
  }
}
