import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

final getWeatherData = ChangeNotifierProvider<WeatherListProvider>((ref) =>WeatherListProvider());
class WeatherListProvider extends ChangeNotifier{
  List<WeatherModel?> weatherReport = [];
  bool isLoading=false;

  WeatherListProvider(){
    getResponse();
  }


  Future<List<WeatherModel?>> getResponse() async {
    weatherReport.clear();
    isLoading = true;
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
    isLoading = false;
    notifyListeners();
    return weatherReport;
    
}


// getWeather() async {
//     isLoading = true;
//     weatherReport = await getResponse();
//     isLoading = false;
//     notifyListeners();
//   }
}

