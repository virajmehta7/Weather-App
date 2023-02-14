class WeatherModel {
  WeatherModel(
      {required this.coord,
      required this.weather,
      required this.main,
      required this.wind,
      required this.name});

  Coord coord;
  List<Weather> weather;
  Main main;
  Wind wind;
  String name;

  String get icon {
    return 'https://openweathermap.org/img/wn/${weather.first.icon}@2x.png';
  }

  get background {
    if (weather.first.main == "Clear")
      return 'assets/images/clear.jpg';
    else if (weather.first.main == "Clouds")
      return 'assets/images/clouds.jpg';
    else if (weather.first.main == "Rain")
      return 'assets/images/rain.jpg';
    else if (weather.first.main == "Drizzle")
      return 'assets/images/drizzle.jpg';
    else if (weather.first.main == "Thunderstorm")
      return 'assets/images/thunderstorm.jpg';
    else if (weather.first.main == "Snow")
      return 'assets/images/snow.jpg';
    else
      return 'assets/images/fog.jpg';
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      coord: Coord.fromJson(json["coord"]),
      weather:
          List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      main: Main.fromJson(json["main"]),
      wind: Wind.fromJson(json["wind"]),
      name: json["name"]);

  Map<String, dynamic> toJson() => {
        "coord": coord.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "wind": wind.toJson(),
        "name": name
      };
}

class Coord {
  Coord({required this.lon, required this.lat});

  double lon;
  double lat;

  factory Coord.fromJson(Map<String, dynamic> json) =>
      Coord(lon: json["lon"]?.toDouble(), lat: json["lat"]?.toDouble());

  Map<String, dynamic> toJson() => {"lon": lon, "lat": lat};
}

class Main {
  Main(
      {required this.temp,
      required this.feelsLike,
      required this.pressure,
      required this.humidity});

  int temp;
  int feelsLike;
  int pressure;
  int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
      temp: json["temp"]?.toInt(),
      feelsLike: json["feels_like"]?.toInt(),
      pressure: json["pressure"],
      humidity: json["humidity"]);

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity
      };
}

class Weather {
  Weather({required this.main, required this.description, required this.icon});

  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      main: json["main"], description: json["description"], icon: json["icon"]);

  Map<String, dynamic> toJson() =>
      {"main": main, "description": description, "icon": icon};
}

class Wind {
  Wind({required this.speed});

  double speed;

  factory Wind.fromJson(Map<String, dynamic> json) =>
      Wind(speed: json["speed"]?.toDouble());

  Map<String, dynamic> toJson() => {"speed": speed};
}
