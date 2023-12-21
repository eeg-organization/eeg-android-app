import 'package:get_storage/get_storage.dart';

class Constants {
  static String apiUrl = 'https://api.knowurmind.com/api/v1';
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

String predictionUrl = 'http://65.2.70.71:8080/';
