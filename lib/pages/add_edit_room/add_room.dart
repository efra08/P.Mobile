import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posttest6/pages/mainpage/mainpage_controller.dart';

import '../dashboard/dashboard_controller.dart';
import 'add_room_controller.dart';
import 'text_field/add_text_field.dart';

enum DeviceType { cooling, lightning, security }

class AddRoom extends StatefulWidget {
  AddRoom({Key? key}) : super(key: key);

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  AddRoomController controller = Get.put(AddRoomController());

  Future _getIcon() {
    return Get.defaultDialog(
      title: "Choose Icon",
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      content: SizedBox(
        width: 250,
        height: 200,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 70,
            childAspectRatio: 1,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: controller.room.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => controller.currentIcon.value = index,
              child: Obx(() {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: (controller.currentIcon.value == index)
                            ? Colors.blue
                            : Colors.black,
                        width: 3),
                  ),
                  child: Image.asset(
                    controller.room[index],
                  ),
                );
              }),
            );
          },
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 70,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Center(
              child: Text('Close'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                "Add Room",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: GestureDetector(
                onTap: () => _getIcon(),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                    color: const Color(0xffFCF7D3),
                  ),
                  child: Obx(() {
                    return Image.asset(
                      controller.room[controller.currentIcon.value],
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Room Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => controller.roomName.value = value,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Center(
                  child: Image.asset(
                    'assets/light.png',
                    color: Colors.black,
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(width: 7),
                Text(
                  'Lightning Devices',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 5),
            ..._getLightningDevices(),
            SizedBox(height: 15),
            Row(
              children: [
                Center(
                  child: Image.asset(
                    'assets/cooling.png',
                    color: Colors.black,
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(width: 7),
                Text(
                  'Cooling Devices',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 5),
            ..._getCoolingDevices(),
            SizedBox(height: 15),
            Row(
              children: [
                Center(
                  child: Image.asset(
                    'assets/secure.png',
                    color: Colors.black,
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(width: 7),
                Text(
                  'Security Devices',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 5),
            ..._getSecurityDevices(),
            SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                controller.addRoom().then((value) {
                  if (value) {
                    Get.defaultDialog(
                      title: '',
                      content: Container(
                        child: Column(
                          children: [
                            Text(
                              'Room has been added',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 30),
                            Center(
                              child: GestureDetector(
                                onTap: () => Get.back(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueAccent,
                                  ),
                                  width: 75,
                                  height: 50,
                                  child: Center(child: Text("Oke")),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                    Get.find<DashboardController>().changeTabIndex(1);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to add room'),
                      ),
                    );
                  }
                });
              },
              child: Center(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueAccent,
                  ),
                  child: Center(
                    child: Text(
                      "Tambah Ruangan",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  List<Widget> _getLightningDevices() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < controller.lightningDevices.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(child: AddLightningDeviceTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(
              i == controller.lightningDevices.length - 1,
              i,
              DeviceType.lightning,
            ),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  List<Widget> _getCoolingDevices() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < controller.coolingDevices.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(child: AddCoolingDeviceTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(
              i == controller.coolingDevices.length - 1,
              i,
              DeviceType.cooling,
            ),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  List<Widget> _getSecurityDevices() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < controller.securityDevices.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(child: AddSecurityDeviceTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(
              i == controller.securityDevices.length - 1,
              i,
              DeviceType.security,
            ),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  Widget _addRemoveButton(bool add, int index, DeviceType type) {
    return InkWell(
      onTap: () {
        if (type == DeviceType.lightning) {
          if (add) {
            controller.lightningDevices.add('');
          } else {
            controller.lightningDevices.removeAt(index);
          }
        } else if (type == DeviceType.cooling) {
          if (add) {
            controller.coolingDevices.add('');
          } else {
            controller.coolingDevices.removeAt(index);
          }
        } else {
          if (add) {
            controller.securityDevices.add('');
          } else {
            controller.securityDevices.removeAt(index);
          }
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}
