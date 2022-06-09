import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_room_controller.dart';
import '../edit_room/edit_room_controller.dart';

class EditLightningDeviceTextFields extends StatefulWidget {
  final controller = Get.find<EditRoomController>();
  final int index;
  EditLightningDeviceTextFields(this.index);
  @override
  _EditLightningDeviceTextFieldsState createState() =>
      _EditLightningDeviceTextFieldsState();
}

class _EditLightningDeviceTextFieldsState
    extends State<EditLightningDeviceTextFields> {
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

class EditSecurityDeviceTextFields extends StatefulWidget {
  final controller = Get.find<EditRoomController>();
  final int index;
  EditSecurityDeviceTextFields(this.index);
  @override
  _EditSecurityDeviceTextFieldsState createState() =>
      _EditSecurityDeviceTextFieldsState();
}

class _EditSecurityDeviceTextFieldsState
    extends State<EditSecurityDeviceTextFields> {
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

class EditCoolingDeviceTextFields extends StatefulWidget {
  final controller = Get.find<EditRoomController>();
  final int index;
  EditCoolingDeviceTextFields(this.index);
  @override
  _EditCoolingDeviceTextFieldsState createState() =>
      _EditCoolingDeviceTextFieldsState();
}

class _EditCoolingDeviceTextFieldsState
    extends State<EditCoolingDeviceTextFields> {
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
