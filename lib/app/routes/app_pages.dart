import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/ambulance/bindings/ambulance_binding.dart';
import '../modules/ambulance/views/ambulance_view.dart';
import '../modules/beranda/bindings/beranda_binding.dart';
import '../modules/beranda/views/beranda_view.dart';
import '../modules/dokter/bindings/dokter_binding.dart';
import '../modules/dokter/views/dokter_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kendaraan/bindings/kendaraan_binding.dart';
import '../modules/kendaraan/views/kendaraan_view.dart';
import '../modules/layanan/bindings/layanan_binding.dart';
import '../modules/layanan/views/layanan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/rumah_sakit/bindings/rumah_sakit_binding.dart';
import '../modules/rumah_sakit/views/rumah_sakit_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
     GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.BERANDA,
      page: () => BerandaView(),
      binding: BerandaBinding(),
    ),
    GetPage(
      name: _Paths.RUMAH_SAKIT,
      page: () => RumahSakitView(),
      binding: RumahSakitBinding(),
    ),
    GetPage(
      name: _Paths.DOKTER,
      page: () => DokterView(),
      binding: DokterBinding(),
    ),
    GetPage(
      name: _Paths.LAYANAN,
      page: () => LayananView(),
      binding: LayananBinding(),
    ),
    GetPage(
      name: _Paths.AMBULANCE,
      page: () => AmbulancePage(),
      binding: AmbulanceBinding(),
    ),
    GetPage(
      name: _Paths.KENDARAAN,
      page: () => KendaraanView(),
      binding: KendaraanBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => AdminView(),
      binding: AdminBinding(),
    ),
  ];
}
