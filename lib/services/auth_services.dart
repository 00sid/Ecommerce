import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance.collection("admins");
  Future<DocumentSnapshot> signAdmin(String id) async {
    var result = await _fireStore.doc(id).get();
    return result;
  }

  Future<String> signIn(String email, String password) async {
    String res = "error";

    try {
      // ignore: unused_local_variable
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      res = "success";
      return res;
    } on FirebaseAuthException catch (e) {
      print(e);
      toastMessage(e.toString());
      return res;
    } catch (e) {
      print(e);
      toastMessage(e.toString());
      return res;
    }
  }

  Future<String> login(String email, String password) async {
    String res = "error";
    try {
      // ignore: unused_local_variable
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      res = "success";
      return res;
    } on FirebaseAuthException catch (e) {
      toastMessage(e.toString());
      return res;
    } catch (e) {
      toastMessage(e.toString());
      return res;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
