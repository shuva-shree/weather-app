import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
// import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:weather/models/api-service.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/provider/list_provider.dart';
// import 'package:weather/provider/list_provider.dart';
import 'package:weather/provider/themes.dart';
import 'package:weather/widgets/weather_list.dart';

class HomeScreen extends ConsumerWidget {
  bool isRefreshed = false;
  List<WeatherModel?> futureweatherReport = [];
  // @override
  // void initState() {
  //   super.initState();
  // }

  String getIcon(String icon) => Uri(
        scheme: "https",
        host: "openweathermap.org",
        pathSegments: {"img", "wn", "$icon@2x.png"},
      ).toString();

  showDurationOfTestimony(String dateTime) {
    final DateFormat formatter = DateFormat.yMMMd('en_US');
    DateTime postDateTime = DateTime.parse(dateTime).toLocal();
    DateTime currDateTime = DateTime.now().toLocal();
    Duration differenceInPostAndCurr = currDateTime.difference(postDateTime);

    return formatter.format(DateTime.parse(dateTime).toLocal());
  }

  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FLutter Weather App'),
          actions: [
            IconButton(
                onPressed: () => currentTheme.toggleTheme(),
                icon: Icon(Icons.brightness_4_rounded))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          // color: Colors.cyan[800],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: EdgeInsets.only(top: 150),
                        alignment: Alignment.bottomCenter,
                        height: 330,
                        child: Consumer(
                          builder: (context, watch, _) {
                            final updatedData = watch(getUpdatedData);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  updatedData.name,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  updatedData.weather,
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  ((updatedData.temp * 9 / 5 - 459.67)
                                              .toString())
                                          .substring(0, 4) +
                                      " °F",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  height: 45,
                                  child: Image.network(
                                    getIcon(updatedData.icon),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  showDurationOfTestimony(
                                      DateTime.now().toString()),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  DateTime.now().toString().substring(10, 16),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ],
                            );
                          },
                        )),
                  ),
                  SizedBox(
                    height: 10,
                    child: Consumer(builder: (watch, model, _) {
                      return IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            print("refresh pressed");
                            watch.read(getUpdatedData).setIsloading();
                            watch.read(getWeatherData).getResponse();
                            
                            // model.setIsloading();
                            // model.getWeather();
                          });
                    }),
                    //         ),
                  ),
                  SizedBox(
                    height: 110,
                  ),
                  WeatherList(context: context),
                ],
              ),
            ],
          ),
        ));
    // );
  }
}
