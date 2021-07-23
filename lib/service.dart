import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class Service{

  getWeather(city) async {
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=a3b1e5dc7a8bfffaaa2760cafadd99c9');
    var res = await http.get(url);
    var json = jsonDecode(res.body);
    return Weather.fromJson(json);
  }

}