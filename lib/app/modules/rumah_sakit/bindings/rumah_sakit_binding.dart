import 'package:get/get.dart';

import '../controllers/rumah_sakit_controller.dart';

class RumahSakitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RumahSakitController>(
      () => RumahSakitController(),
    );
  }
}
