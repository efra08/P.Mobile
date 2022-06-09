import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRoomController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late CollectionReference dataRooms;

  @override
  void onInit() {
    super.onInit();
    dataRooms = firestore
        .collection('rooms')
        .doc(auth.currentUser!.uid)
        .collection('room');
  }

  List<String> room = [
    'assets/bathroom.png',
    'assets/bedroom.png',
    'assets/kitchen.png',
    'assets/livingroom.png',
    'assets/storeroom.png',
    'assets/studyroom.png'
  ];
  var currentIcon = 0.obs;
  var roomName = ''.obs;

  var lightningDevices = [''].obs;
  var coolingDevices = [''].obs;
  var securityDevices = [''].obs;

  void setRoomName(String value) {
    roomName.value = value;
    print(roomName.value);
  }

  void setLightningDevices(String value, int index) {
    lightningDevices[index] = value;
    print(lightningDevices);
  }

  void setCoolingDevices(String value, int index) {
    coolingDevices[index] = value;
    print(coolingDevices);
  }

  void setSecurityDevices(String value, int index) {
    securityDevices[index] = value;
    print(securityDevices);
  }

  Future<bool> addRoom() async {
    var lightningDeviceMap = {for (var e in lightningDevices) e: false};
    lightningDeviceMap.removeWhere((key, value) => key == '');
    var coolingDeviceMap = {for (var e in coolingDevices) e: false};
    coolingDeviceMap.removeWhere((key, value) => key == '');
    var securityDeviceMap = {for (var e in securityDevices) e: false};
    securityDeviceMap.removeWhere((key, value) => key == '');

    try {
      await dataRooms.add({
        'name': roomName.value,
        'icon': room[currentIcon.value],
        'total': lightningDeviceMap.length +
            coolingDeviceMap.length +
            securityDeviceMap.length,
        'lightningDevices': lightningDeviceMap,
        'coolingDevices': coolingDeviceMap,
        'securityDevices': securityDeviceMap,
      });

      lightningDevices.value = [''];
      coolingDevices.value = [''];
      securityDevices.value = [''];
      roomName.value = '';
      currentIcon.value = 0;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
