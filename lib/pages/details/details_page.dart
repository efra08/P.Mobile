import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posttest6/pages/add_edit_room/add_room.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'details_controller.dart';

class DetailsPage extends StatelessWidget {
  //final List<Widget> tabBody = [Details1(), Details2(), Details3()];

  DetailsController controller = Get.put(DetailsController(Get.arguments));
  //List<Widget> tabBody = [details1(), Details2(), Details3()];

  Widget menuList(String txt, bool isOn, DeviceType type) {
    return Container(
      width: Get.width / 1.1,
      height: Get.height / 15,
      margin: EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 6,
              spreadRadius: 0.1,
              color: Colors.grey,
            ),
          ]),
      child: Stack(children: [
        Positioned(
          top: Get.height / 45,
          left: 20,
          child: Text(
            txt,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 10,
          child: StreamBuilder<DocumentSnapshot>(
            stream: controller.firestore
                .collection("rooms")
                .doc(controller.auth.currentUser!.uid)
                .collection('room')
                .doc(controller.data.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var map = Map<String, bool>.from(snapshot.data!
                    .get(type.toString().split(".")[1] + "Devices"));
                return Switch(
                  value: map[txt] as bool,
                  onChanged: (val) {
                    map[txt] = val;
                    controller.firestore
                        .collection("rooms")
                        .doc(controller.auth.currentUser!.uid)
                        .collection('room')
                        .doc(controller.data.id)
                        .update({
                      type.toString().split(".")[1] + "Devices": map,
                    });
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
          appBar: AppBar(
            title: Text((Get.arguments as QueryDocumentSnapshot).get('name')),
            backgroundColor: Color.fromARGB(255, 245, 245, 245),
            foregroundColor: Colors.black,
            bottom: const TabBar(tabs: [
              Tab(
                  child: Text(
                "Lightning",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 1.5,
                ),
              )),
              Tab(
                  child: Text(
                "Cooling",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 1.5,
                ),
              )),
              Tab(
                  child: Text(
                "Security",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 1.5,
                ),
              )),
            ]),
          ),
          body: TabBarView(
            children: [
              Scaffold(
                body: ListView(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height + 160,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            width: Get.width,
                            child: Center(
                              child: Container(
                                width: Get.width / 1.2,
                                height: Get.height / 5,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                        child: Image.asset("assets/light.png")),
                                    Positioned(
                                      width: Get.width / 1.2,
                                      top: Get.height / 17,
                                      child: Center(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
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
                                        "Lightning Devices",
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
                                      child: StreamBuilder<DocumentSnapshot>(
                                        stream: controller.firestore
                                            .collection("rooms")
                                            .doc(controller
                                                .auth.currentUser!.uid)
                                            .collection('room')
                                            .doc(controller.data.id)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var length = snapshot.data!
                                                .get("lightningDevices")
                                                .length;
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
                                      // child: const Text(
                                      //   "5 devices",
                                      //   style: TextStyle(
                                      //     color: Colors.white,
                                      //     fontWeight: FontWeight.normal,
                                      //     fontSize: 12,
                                      //     letterSpacing: 1.5,
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 170,
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              padding: EdgeInsets.all(18),
                              child: ListView(
                                children: controller.lightning.entries.map(
                                  (e) {
                                    return menuList(
                                      e.key,
                                      e.value,
                                      DeviceType.lightning,
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Scaffold(
                body: ListView(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height + 160,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            width: Get.width,
                            child: Center(
                              child: Container(
                                width: Get.width / 1.2,
                                height: Get.height / 5,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                        child:
                                            Image.asset("assets/cooling.png")),
                                    Positioned(
                                      width: Get.width / 1.2,
                                      top: Get.height / 17,
                                      child: Center(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
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
                                        "Cooling Devices",
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
                                      child: StreamBuilder<DocumentSnapshot>(
                                        stream: controller.firestore
                                            .collection("rooms")
                                            .doc(controller
                                                .auth.currentUser!.uid)
                                            .collection('room')
                                            .doc(controller.data.id)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var length = snapshot.data!
                                                .get("coolingDevices")
                                                .length;
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
                          ),
                          Positioned(
                            top: 170,
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              padding: EdgeInsets.all(18),
                              child: ListView(
                                children: controller.cooling.entries.map(
                                  (e) {
                                    return menuList(
                                      e.key,
                                      e.value,
                                      DeviceType.cooling,
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Scaffold(
                body: ListView(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height + 160,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            width: Get.width,
                            child: Center(
                              child: Container(
                                width: Get.width / 1.2,
                                height: Get.height / 5,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                        child:
                                            Image.asset("assets/secure.png")),
                                    Positioned(
                                      width: Get.width / 1.2,
                                      top: Get.height / 17,
                                      child: Center(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
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
                                        "Security Devices",
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
                                      child: StreamBuilder<DocumentSnapshot>(
                                        stream: controller.firestore
                                            .collection("rooms")
                                            .doc(controller
                                                .auth.currentUser!.uid)
                                            .collection('room')
                                            .doc(controller.data.id)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var length = snapshot.data!
                                                .get("securityDevices")
                                                .length;
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
                          ),
                          Positioned(
                            top: 170,
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              padding: EdgeInsets.all(18),
                              child: ListView(
                                children: controller.security.entries.map(
                                  (e) {
                                    return menuList(
                                      e.key,
                                      e.value,
                                      DeviceType.security,
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
