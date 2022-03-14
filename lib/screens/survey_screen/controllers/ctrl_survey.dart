
import 'package:get/get.dart';

class CtrlSurvey extends GetxController {
  Rx<String> indexAnswerDropdown = '0'.obs;
  Rx<int> indexAnswerChoice = 0.obs;
  Rx<List<String>> indexAnswerMultipleSelection = Rx<List<String>>([]);

  Rx<bool> isValidate = false.obs;
}