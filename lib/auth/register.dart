// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

Future<bool> registerFirebase(
  String name,
  String email,
  String password,
) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user!.updateDisplayName(name);
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
