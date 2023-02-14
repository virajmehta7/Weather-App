class ForecastModel {
  ForecastModel(
      {required this.timezone, required this.hourly, required this.daily});

  String timezone;
  List<Hourly> hourly;
  List<Daily> daily;

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
      timezone: json["timezone"],
      hourly: List<Hourly>.from(json["hourly"].map((x) => Hourly.fromJson(x))),
      daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "timezone": timezone,
        "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson()))
      };
}

class Hourly {
  Hourly({required this.dt, required this.temp, required this.main});

  int dt;
  int temp;
  String main;

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
      dt: json["dt"],
      temp: json["temp"]?.toInt(),
      main: json['weather'][0]['main']);

  Map<String, dynamic> toJson() => {"dt": dt, "temp": temp, "main": main};
}

class Daily {
  Daily(
      {required this.dt,
      required this.temp,
      required this.main,
      required this.uvi});

  int dt;
  Temp temp;
  String main;
  double uvi;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
      dt: json["dt"],
      temp: Temp.fromJson(json["temp"]),
      main: json['weather'][0]['main'],
      uvi: json["uvi"]?.toDouble());

  Map<String, dynamic> toJson() =>
      {"dt": dt, "temp": temp.toJson(), "main": main, "uvi": uvi};
}

class Temp {
  Temp({required this.min, required this.max});

  int min;
  int max;

  factory Temp.fromJson(Map<String, dynamic> json) =>
      Temp(min: json["min"]?.toInt(), max: json["max"]?.toInt());

  Map<String, dynamic> toJson() => {"min": min, "max": max};
}
