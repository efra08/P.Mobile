import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: Get.width * 0.5,
                child: Image.asset(
                  'assets/splash.png',
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            //Text("Name"),
            // SizedBox(height: 5),
            // TextField(
            //   decoration: InputDecoration(
            //     labelText: 'Name',
            //   ),
            // ),
            // SizedBox(height: 20),
            //Text("Email"),
            //SizedBox(height: 5),
            TextField(
              onChanged: (value) {
                loginController.emailChanged(value);
              },
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            //Text("Password"),
            //SizedBox(height: 5),
            TextField(
              onChanged: (value) {
                loginController.passwordChanged(value);
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: GestureDetector(
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  loginController.isLoading.value = true;
                  var isLogin = await loginController.login();
                  if (isLogin) {
                    loginController.isLoading.value = false;
                    Get.offAllNamed(AppRoutes.DASHBOARD);
                  } else {
                    loginController.isLoading.value = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login Failed'),
                      ),
                    );
                  }
                },
                child: Obx(
                  () {
                    return Container(
                      child: (loginController.isLoading.value)
                          ? Center(
                              child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ))
                          : Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                      width: Get.width * 0.6,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.SIGNUP);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 5),
                    Text("Back"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
