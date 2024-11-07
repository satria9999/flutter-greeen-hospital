import 'package:get/get.dart';

import '../controllers/dokter_controller.dart';

class DokterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DokterController>(
      () => DokterController(),
    );
  }
}
