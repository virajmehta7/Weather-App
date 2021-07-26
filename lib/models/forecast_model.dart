class Hourly{
  int dt;
  int temp;
  String main;
  String icon;

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