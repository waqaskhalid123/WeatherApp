import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'weather_home.dart';

class WeatherSplash extends StatefulWidget {
  const WeatherSplash({super.key});

  @override
  State<WeatherSplash> createState() => _WeatherSplashState();
}

class _WeatherSplashState extends State<WeatherSplash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () => Get.to(const WeatherHome()));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOTthzfVKTvZqX4BdawRuk7s57DJMi7rj_xg&usqp=CAU'),
          ),
          Text(
            'My Weather',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
          )
        ],
      ),
    ));
  }
}
