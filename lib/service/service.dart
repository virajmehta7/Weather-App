import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/forecast_model.dart';
import 'package:weather/models/weather_model.dart';

class Service {
  getWeather(city) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=87ead33910095ba7c2de5b3fedff2cfe');
    var res = await http.get(url);
    var json = jsonDecode(res.body);
    return WeatherModel.fromJson(json);
  }

  getForecast(lat, lon) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&exclude=current,minutely,alerts&appid=87ead33910095ba7c2de5b3fedff2cfe');
    var res = await http.get(url);
    var json = jsonDecode(res.body);
    return ForecastModel.fromJson(json);
  }
}
