// ignore_for_file: unused_local_variable, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';

Future<bool> loginFirebase(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    return false;
  }
}

Future<bool> logoutFirebase() async {
  try {
    await FirebaseAuth.instance.signOut();
    return true;
  } on Exception catch (e) {
    return false;
  }
}
