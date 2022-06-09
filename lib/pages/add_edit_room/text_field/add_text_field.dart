import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_room_controller.dart';
import '../edit_room/edit_room_controller.dart';

class AddLightningDeviceTextFields extends StatefulWidget {
  final controller = Get.find<AddRoomController>();
  final int index;
  AddLightningDeviceTextFields(this.index);
  @override
  _AddLightningDeviceTextFieldsState createState() =>
      _AddLightningDeviceTextFieldsState();
}

class _AddLightningDeviceTextFieldsState
    extends State<AddLightningDeviceTextFields> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = widget.controller.lightningDevices[widget.index];
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => widget.controller.setLightningDevices(v, widget.index),
      decoration: InputDecoration(hintText: 'Masukkan nama perangkat'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

class AddSecurityDeviceTextFields extends StatefulWidget {
  final controller = Get.find<AddRoomController>();
  final int index;
  AddSecurityDeviceTextFields(this.index);
  @override
  _AddSecurityDeviceTextFieldsState createState() =>
      _AddSecurityDeviceTextFieldsState();
}

class _AddSecurityDeviceTextFieldsState
    extends State<AddSecurityDeviceTextFields> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = widget.controller.securityDevices[widget.index];
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => widget.controller.setSecurityDevices(v, widget.index),
      decoration: InputDecoration(hintText: 'Masukkan nama perangkat'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

class AddCoolingDeviceTextFields extends StatefulWidget {
  final controller = Get.find<AddRoomController>();
  final int index;
  AddCoolingDeviceTextFields(this.index);
  @override
  _AddCoolingDeviceTextFieldsState createState() =>
      _AddCoolingDeviceTextFieldsState();
}

class _AddCoolingDeviceTextFieldsState
    extends State<AddCoolingDeviceTextFields> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = widget.controller.coolingDevices[widget.index];
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => widget.controller.setCoolingDevices(v, widget.index),
      decoration: InputDecoration(hintText: 'Masukkan nama perangkat'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
