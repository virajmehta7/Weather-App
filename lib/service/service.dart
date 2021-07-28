import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/forecast_model.dart';
import 'package:weather/models/weather_model.dart';

class Service{

  getWeather(city) async {
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=a3b1e5dc7a8bfffaaa2760cafadd99c9');
    var res = await http.get(url);
    var json = jsonDecode(res.body);
    return Weather.fromJson(json);
  }

  getForecast(lat, lon) async {
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&exclude=current,minutely,alerts&appid=a3b1e5dc7a8bfffaaa2760cafadd99c9');
    var res = await http.get(url);
    var json = jsonDecode(res.body);
    return Forecast.fromJson(json);
  }

}