import 'package:get/get.dart';
import '../bindings/auth_binding.dart';
import '../screens/home_screen.dart';
import '../screens/otp_verification_screen.dart';
import '../screens/phone_login_screen.dart';


class AppPages {
  static final routes = [
    GetPage(name: '/phone', page: () => PhoneInputScreen(), binding: AuthBinding()),
    GetPage(name: '/otp', page: () => OTPVerificationScreen(), binding: AuthBinding()),
    GetPage(name: '/home', page: () => HomeScreen(), binding: AuthBinding()),
  ];
}
