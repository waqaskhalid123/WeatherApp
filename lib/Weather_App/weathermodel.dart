import "package:flutter/material.dart";
// To parse this JSON data, do
//
//     final myWeather = myWeatherFromMap(jsonString);

// To parse this JSON data, do
//
//     final myWeather = myWeatherFromMap(jsonString);

import 'dart:convert';

class WeatherModel {
  final Map<String, dynamic> coord;
  final List<dynamic> weather;
  final String base;
  final Map<String, dynamic> main;
  final int visibility;
  final Map<String, dynamic> wind;
  final Map<String, dynamic> clouds;
  final int dt;
  final Map<String, dynamic> sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      coord: json['coord'],
      weather: json['weather'],
      base: json['base'],
      main: json['main'],
      visibility: json['visibility'],
      wind: json['wind'],
      clouds: json['clouds'],
      dt: json['dt'],
      sys: json['sys'],
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'] ?? '',
      cod: json['cod'],
    );
  }

  @override
  String toString() {
    return 'WeatherModel(coord: $coord, weather: $weather, base: $base, '
        'main: $main, visibility: $visibility, wind: $wind, clouds: $clouds, '
        'dt: $dt, sys: $sys, timezone: $timezone, id: $id, name: $name, '
        'cod: $cod)';
  }
}
