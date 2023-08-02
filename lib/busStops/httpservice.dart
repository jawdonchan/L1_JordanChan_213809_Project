import 'package:http/http.dart' as http;
import 'BusStop.dart';

class HttpService {
  static const String url =
      'http://datamall2.mytransport.sg/ltaodataservice/BusStops';
  static Future<List<Value>> getBusStops() async {
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
