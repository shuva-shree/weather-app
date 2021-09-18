import 'package:flutter/cupertino.dart';
import 'package:weather/models/api-service.dart';
import '../models/weather_model.dart';

class ListProvider extends ChangeNotifier {
  String name = "Boston";
  String weather = "Rainy";
  String icon = "03d";
  double temp = 305.4;
  String date = "23-08-21";
  String time = "18:16";

  bool isLoading = false;

  List<WeatherModel?> weatherReport = [];

  updateWeather(String n, String w, double t, String d, String ti, String i) {
    name = n;
    weather = w;
    temp = t;
    date = d;
    time = ti;
    icon = i;
    notifyListeners();
  }

  setIsloading() {
    isLoading = true;
    notifyListeners();
  }

  getWeather() async {
    isLoading = true;
    weatherReport = await getResponse();
    isLoading = false;
    notifyListeners();
  }
}
