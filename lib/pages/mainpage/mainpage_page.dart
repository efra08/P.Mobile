import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posttest6/pages/details/details_page.dart';
import 'package:posttest6/pages/mainpage/mainpage_controller.dart';
import 'package:posttest6/routes/app_routes.dart';

class MainPage extends GetView<MainpageController> {
  Future<dynamic> dialog(context, e) {
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        height: 140,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.EDITROOM, arguments: e);
              },
              child: Text(
                "Edit Room",
                style: TextStyle(fontSize: 19),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                FirebaseFirestore.instance
                    .collection("rooms")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('room')
                    .doc(e.id)
                    .delete();
                Get.back();
                ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                  content: Text("Room Deleted"),
                )));
              },
              child: Text(
                "Delete Room",
                style: TextStyle(fontSize: 19),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 20),
          Center(
            child: Container(
              width: Get.width / 1.2,
              height: Get.height / 5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 0, 162, 255),
                      Color.fromARGB(255, 66, 45, 255),
                    ]),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 0.2,
                    color: Colors.grey,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                      top: Get.height / 17,
                      left: Get.width / 7,
                      child: Image.asset("assets/smarthome.png")),
                  Positioned(
                    width: Get.width / 1.2,
                    top: Get.height / 17,
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        width: Get.width / 200,
                        height: Get.height / 11,
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.height / 15,
                    left: Get.width / 1.9,
                    child: const Text(
                      "All Devices",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.height / 9,
                    left: Get.width / 1.9,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("rooms")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('room')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var list = snapshot.data!.docs;
                          var length = 0;
                          list.forEach((element) {
                            length += element.get('total') as int;
                          });
                          return Text(
                            "$length devices",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              letterSpacing: 1.5,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          //SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(30),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("rooms")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("room")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.size != 0) {
                    return GridView.count(
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: snapshot.data!.docs.map((e) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.DETAILS, arguments: e);
                          },
                          onLongPress: () {
                            dialog(context, e);
                          },
                          child: menuCon(
                            e.get('icon'),
                            e.get('name'),
                            context,
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: Text("No Rooms"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget menuCon(String file, String judul, context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(file),
        SizedBox(
          height: 10,
        ),
        Text(
          judul,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
