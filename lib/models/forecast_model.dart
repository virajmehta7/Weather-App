class Forecast{
  String? timezone;
  final List<Hourly>? hourly;
  final List<Daily>? daily;

  Forecast({
    this.timezone,
    this.hourly,
    this.daily
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      timezone: json['timezone'],
      hourly: hourlyJson(json),
      daily: dailyJson(json),
    );
  }

  static List<Hourly> hourlyJson(json) {
    List<dynamic> body = json['hourly'];
    List<Hourly> forecast = body.map((item) => Hourly.fromJson(item)).toList();
    return forecast;
  }

  static List<Daily> dailyJson(json) {
    List<dynamic> body = json['daily'];
    List<Daily> forecast = body.map((item) => Daily.fromJson(item)).toList();
    return forecast;
  }
}

class Hourly{
  int? dt;
  int? temp;
  String? main;
  String? icon;

  String get icons {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }

  Hourly({
    this.dt,
    this.temp,
    this.main,
    this.icon
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      dt: json['dt'].toInt(),
      temp: json['temp'].toInt(),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon']
    );
  }
}

class Daily{
  int? dt;
  Temp? temp;
  String? main;
  String? icon;

  String get icons {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }

  Daily({
    this.dt,
    this.temp,
    this.main,
    this.icon
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      dt: json['dt'].toInt(),
      temp: Temp.fromJson(json['temp']),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon']
    );
  }

}

class Temp{
  int? min;
  int? max;

  Temp({
    this.min,
    this.max
  });

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      min: json['min'].toInt(),
      max: json['max'].toInt()
    );
  }
}