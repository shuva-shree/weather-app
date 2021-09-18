import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_model.dart';


List<String> cities = [
  "Marib City",
  "Cooperabung",
  "Akbarpur",
  "Khlong Yai",
  "Pangkajene",
  "Toboso",
  "Zhili",
  "Bonnet Bay",
  "Donskoye",
  "Lourdes"
];
List<WeatherModel> weatherReport = [];

Future<List<WeatherModel?>> getResponse() async {
  weatherReport.clear();

  for (String city in cities) {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=02ec7938b70b1ab982789265da874d88");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var weather = WeatherModel.fromJson(jsonDecode(response.body));
        weatherReport.add(weather);
      }
    } catch (error) {
      throw error;
    }
  }
  return weatherReport;
}
