import "dart:convert";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:http/http.dart" as http;
import "weathermodel.dart";

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  void initState() {
    weatherCallingApi();
    // getData();
    // TODO: implement initState
    print(textfield);
    print(w);
    super.initState();
    setState(() {});
  }

  String? textfield = 'islamabad';
  WeatherModel? w;
  String? weather_description;
  String? temp;
  String? speed;
  String? humidity;
  String? cityName;
  dynamic icon;
  weatherCallingApi() async {
    w = await getData(textfield.toString());
    if (w != null) {
      weather_description = w!.weather[0]['description'];
      temp = (w!.main['temp'] - 273.15).toString();
      speed = (w!.wind['speed'] / 0.27777777777778).toString();
      humidity = (w!.main['humidity']).toString();
      cityName = w!.name;
      icon = w!.weather[0]['icon'];
      setState(() {});
    } else {
      print("Weather data is null");
    }
  }

  TextEditingController cont1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: weather_description == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Color(0xff4e9ee7),
              child: Column(
                children: [
                  //TextField
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: Get.height * 0.02),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                weatherCallingApi();
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              //color:Colors.red,
                              //margin: EdgeInsets.only(left: 12, top: 5),
                              //height: Get.height * 0.08,
                              //width: Get.width * 0.08,
                              child: TextField(
                                onChanged: (value) {
                                  textfield = value;
                                  setState(() {});
                                  print(textfield);
                                },
                                //controller: cont1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter City",
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Weather Container
                  //1sr container
                  SizedBox(height: Get.height * 0.03),

                  Expanded(
                      flex: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffa1ccef),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(
                                'https://openweathermap.org/img/wn/$icon.png'),
                            //Icon(Icons.sunny, size: Get.width * 0.08),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  weather_description.toString(),
                                  style: TextStyle(
                                      fontSize: Get.width * 0.05,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  cityName.toString(),
                                  style: TextStyle(
                                      fontSize: Get.width * 0.03,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                  SizedBox(height: Get.height * 0.03),

                  //2nd Container
                  weatherContainer(40, Icons.thermostat,
                      temp.toString().substring(0, 4), "c", 0.08),
                  SizedBox(height: Get.height * 0.03),
                  Expanded(
                    flex: 40,
                    child: Row(
                      children: [
                        weatherContainer(1, Icons.wind_power,
                            speed.toString().substring(0, 4), "km/hr", 0.03),
                        SizedBox(width: Get.width * 0.03),
                        weatherContainer(1, Icons.water_drop,
                            humidity.toString(), "percent", 0.03),
                      ],
                    ),
                  ),
                  Container(
                    height: Get.height * 0.1,
                    child: Center(
                        child: Text("Data provided by openweatherapp.org",
                            style: TextStyle(color: Colors.white))),
                  ),
                ],
              ),
            ),
    );
  }

  weatherContainer(
      int flex, var icon, String value, String unit, double textHeight) {
    return Expanded(
        flex: flex,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.02),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffa1ccef),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: Get.width * 0.05,
                  ),
                  Spacer(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value.toString(),
                    style: TextStyle(
                        fontSize: Get.width * 0.1, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: Get.width * 0.01),
                  Text(
                    unit,
                    style: TextStyle(fontSize: Get.width * 0.03),
                  ),
                ],
              ),
              SizedBox(height: Get.height * textHeight),
            ],
          ),
        ));
  }

  //Api
  getData(String City) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$City&appid=e5a1afd2ac6448ed2e740790754bfa3f";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var weather = WeatherModel.fromJson(data);
      return weather;
    } else {
      print("Something went wrong");
    }
  }
}
