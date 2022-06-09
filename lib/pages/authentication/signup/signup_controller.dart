import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../auth/register.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  void emailChanged(String newEmail) {
    email.value = newEmail;
    print(email.value);
  }

  void passwordChanged(String newPassword) {
    password.value = newPassword;
    print(password.value);
  }

  void nameChanged(String newName) {
    name.value = newName;
    print(name.value);
  }

  Future<bool> signUp() async {
    var isRegistered = await registerFirebase(
      name.value,
      email.value,
      password.value,
    );
    if (isRegistered) {
      return true;
    } else {
      return false;
    }
  }
}
