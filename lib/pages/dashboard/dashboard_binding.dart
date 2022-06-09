import 'package:get/get.dart';
import 'package:posttest6/pages/account/account_controller.dart';
import 'package:posttest6/pages/home/home_controller.dart';

import '../add_edit_room/add_room_controller.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AccountController>(() => AccountController());
    Get.lazyPut<AddRoomController>(() => AddRoomController());
  }
}
