import 'dart:convert';
import 'package:http/http.dart' as http;

class DataFormat {
  Location location;
  Current current;

  DataFormat({this.location, this.current});

  factory DataFormat.fromJson(Map<dynamic, dynamic> json) {
    return DataFormat(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]));
  }
}

class Location {
  String name, country, locatime;

  Location({this.name, this.country, this.locatime});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        name: json["name"],
        country: json["country"],
        locatime: json["localtime"]);
  }
}

class Current {
  String observationTime;
  double temperature, wind, pressure;
  int humidity, isDay;
  Condition condition;

  Current(
      {this.temperature,
      this.wind,
      this.pressure,
      this.humidity,
      this.isDay,
      this.observationTime,
      this.condition});

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
        temperature: json["temp_c"],
        wind: json["wind_kph"],
        pressure: json["pressure_mb"],
        humidity: json["humidity"],
        isDay: json["is_day"],
        observationTime: json["last_updated"],
        condition: Condition.fromJson(json["condition"]));
  }
}

class Condition {
  String weatherDescription;
  String icon;

  Condition({this.weatherDescription, this.icon});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(weatherDescription: json["text"], icon: json["icon"]);
  }
}

Future<dynamic> fetchData(String place) async {
  var responseJson;
  final String apiKey = "0daacb06f5e14fcabfe115043202809";
  final url = Uri.parse(
      "https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$place&aqi=no");

  final response = await http.Client().get(url);

  if (response.statusCode == 200) {
    responseJson = DataFormat.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load");
  }

  return responseJson;
}
