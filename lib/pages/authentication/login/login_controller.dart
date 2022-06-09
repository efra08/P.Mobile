import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../auth/login.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
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

  Future<bool> login() async {
    var isLogged = await loginFirebase(email.value, password.value);
    if (isLogged) {
      return true;
    } else {
      return false;
    }
  }
}
