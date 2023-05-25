import 'package:get_storage/get_storage.dart';

class Constants {
  static String apiUrl = 'http://35.154.215.124:8000/api/v1';
  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  // GetStorage box = GetStorage();
  Map<String, String> authHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('loginDetails')['token']}'
  };
}
