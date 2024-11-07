import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'package:green_hospital/app/modules/splash/views/splash_view.dart';
import 'package:green_hospital/app/modules/login/views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  final box = GetStorage();
  final bool hasLoggedIn = box.read('hasLoggedIn') ?? false;

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: hasLoggedIn ? Routes.LOGIN : Routes.SPLASH,
      getPages: AppPages.routes,
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)), // Ganti ini dengan logika splash screen Anda
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SplashScreen(); // Ganti ini dengan widget splash screen Anda
          } else {
            return Container(); // Selama splash screen, bisa saja tampilkan loader atau apapun yang sesuai
          }
        },
      ),
    ),
  );
}
