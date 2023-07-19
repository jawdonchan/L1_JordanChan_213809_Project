import 'package:http/http.dart' as http;
import 'package:proj_layout/carpark/Carparks.dart';

class HttpService {
  static const String url =
      'http://datamall2.mytransport.sg/ltaodataservice/CarParkAvailabilityv2';
  static Future<List<Value>> getCarparks() async {
    try {
      final response = await http.get(url, headers: {
        'AccountKey': 'nQmYcxLjQKq6Wo4qo2BoXw==',
        'accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final Welcome cp = welcomeFromJson(response.body);
        return cp.value;
      } else {
        return List<Value>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<Value>();
    }
  } //getCarparks
} //HttpService
