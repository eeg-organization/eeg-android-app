import 'package:get/get.dart';

class CounterController extends GetxController {
  var current_step = 0.obs;
  var selectedValue = 0.obs;
  increment() {
    current_step++;
  }

  decrement() {
    current_step--;
  }
}
