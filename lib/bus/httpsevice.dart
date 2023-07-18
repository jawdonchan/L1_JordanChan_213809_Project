import 'package:http/http.dart' as http;
import 'package:proj_layout/bus/buses.dart';

class HttpService {
  static const String baseUrl =
      'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=54351';

  static Future<List<Service>> getBusStop(String busStopCode) async {
    try {
      final url = '$baseUrl?BusStopCode=$busStopCode';
      final response = await http.get(url, headers: {
        'AccountKey': 'nQmYcxLjQKq6Wo4qo2BoXw==',
        'accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final BusArrival cp = busArrivalFromJson(response.body);
        return cp.services;
      } else {
        return List<Service>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<Service>();
    }
  }
}
