import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import 'account_controller.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(children: [
            SizedBox(height: 50),
            Image.asset(
              'assets/profile.png',
              width: 70,
              height: 70,
            ),
            SizedBox(height: 15),
            Text(
              "Halo, ${controller.user?.displayName}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("Logout"),
              onPressed: () {
                controller.logout();
                Get.offAllNamed(AppRoutes.HOMEPAGE);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
