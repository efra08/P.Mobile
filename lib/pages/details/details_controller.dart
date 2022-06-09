import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QueryDocumentSnapshot<Object?> data;
  FirebaseAuth auth = FirebaseAuth.instance;

  DetailsController(this.data);

  late Map<String, bool> lightning;
  late Map<String, bool> cooling;
  late Map<String, bool> security;

  @override
  void onInit() {
    super.onInit();
    lightning = Map<String, bool>.from(data.get('lightningDevices'));
    cooling = Map<String, bool>.from(data.get('coolingDevices'));
    security = Map<String, bool>.from(data.get('securityDevices'));
  }
}
