import 'package:get/get.dart';

import 'package:preferensi/app/modules/add_pegawai/bindings/add_pegawai_binding.dart';
import 'package:preferensi/app/modules/add_pegawai/views/add_pegawai_view.dart';
import 'package:preferensi/app/modules/forget_password/bindings/forget_password_binding.dart';
import 'package:preferensi/app/modules/forget_password/views/forget_password_view.dart';
import 'package:preferensi/app/modules/home/bindings/home_binding.dart';
import 'package:preferensi/app/modules/home/views/home_view.dart';
import 'package:preferensi/app/modules/login/bindings/login_binding.dart';
import 'package:preferensi/app/modules/login/views/login_view.dart';
import 'package:preferensi/app/modules/new_password/bindings/new_password_binding.dart';
import 'package:preferensi/app/modules/new_password/views/new_password_view.dart';
import 'package:preferensi/app/modules/profile/bindings/profile_binding.dart';
import 'package:preferensi/app/modules/profile/views/profile_view.dart';
import 'package:preferensi/app/modules/register/bindings/register_binding.dart';
import 'package:preferensi/app/modules/register/views/register_view.dart';
import 'package:preferensi/app/modules/update_password/bindings/update_password_binding.dart';
import 'package:preferensi/app/modules/update_password/views/update_password_view.dart';
import 'package:preferensi/app/modules/update_profile/bindings/update_profile_binding.dart';
import 'package:preferensi/app/modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PEGAWAI,
      page: () => AddPegawaiView(),
      binding: AddPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
  ];
}
