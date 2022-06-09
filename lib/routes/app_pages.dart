import 'package:get/get.dart';
import '../pages/add_edit_room/edit_room/edit_room.dart';
import '../pages/authentication/login/login_page.dart';
import '../pages/authentication/signup/signup_page.dart';
import '../pages/dashboard/dashboard_binding.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/details/details_page.dart';
import '../pages/home/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.HOMEPAGE,
      page: () => HomePage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: AppRoutes.DETAILS,
      page: () => DetailsPage(),
    ),
    GetPage(
      name: AppRoutes.EDITROOM,
      page: () => EditRoom(),
    ),
  ];
}
