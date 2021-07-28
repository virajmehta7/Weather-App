class Weather{
  String cityName;
  CoordInfo coordInfo;
  TemperatureInfo temperatureInfo;
  WeatherInfo weatherInfo;
  WindInfo windInfo;

  String get icon {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  get background {
    if (weatherInfo.main == "Thunderstorm")
      return 'assets/thunderstorm.jpg';
    if (weatherInfo.main == "Drizzle")
      return 'assets/drizzle.jpg';
    if (weatherInfo.main == "Rain")
      return 'assets/rain.jpg';
    if (weatherInfo.main == "Snow")
      return 'assets/snow.jpg';
    if (weatherInfo.main == "Snow")
      return 'assets/snow.jpg';
    if (weatherInfo.main == "Clear")
      return 'assets/clear.jpg';
    if (weatherInfo.main == "Clouds")
      return 'assets/clouds.jpg';
    if (weatherInfo.main == "Mist" ||
        weatherInfo.main == "Smoke" ||
        weatherInfo.main == "Haze" ||
        weatherInfo.main == "Dust" ||
        weatherInfo.main == "Fog" ||
        weatherInfo.main == "Sand" ||
        weatherInfo.main == "Ash" ||
        weatherInfo.main == "Squall" ||
        weatherInfo.main == "Tornado"
    )
      return 'assets/fog.jpg';

  }

  Weather({
    this.cityName,
    this.coordInfo,
    this.temperatureInfo,
    this.weatherInfo,
    this.windInfo,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      coordInfo: CoordInfo.fromJson(json['coord']),
      temperatureInfo: TemperatureInfo.fromJson(json['main']),
      weatherInfo: WeatherInfo.fromJson(json['weather'][0]),
      windInfo: WindInfo.fromJson(json['wind']),
    );
  }
}

class CoordInfo{
  double lon;
  double lat;

  CoordInfo({
    this.lon,
    this.lat
  });

  factory CoordInfo.fromJson(Map<String, dynamic> json) {
    return CoordInfo(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble()
    );
  }
}

class TemperatureInfo{
  int temp;
  int feels;
  int pressure;
  int humidity;

  TemperatureInfo({
    this.temp,
    this.feels,
    this.pressure,
    this.humidity
  });

  factory TemperatureInfo.fromJson(Map<String, dynamic> json){
    return TemperatureInfo(
      temp: json['temp'].toInt(),
      feels: json['feels_like'].toInt(),
      pressure: json['pressure'].toInt(),
      humidity: json['humidity'].toInt()
    );
  }
}

class WeatherInfo{
  String main;
  String desc;
  String icon;

  WeatherInfo({
    this.main,
    this.desc,
    this.icon
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json){
    return WeatherInfo(
      main: json['main'],
      desc: json['description'],
      icon: json['icon']
    );
  }
}

class WindInfo{
  int speed;

  WindInfo({this.speed});

  factory WindInfo.fromJson(Map<String, dynamic> jsom){
    return WindInfo(
      speed: jsom['speed'].toInt()
    );
  }
}