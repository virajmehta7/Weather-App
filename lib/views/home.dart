import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/service/service.dart';
import 'package:weather/views/daily_tile.dart';
import 'package:weather/views/hourly_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Service service = Service();

  TextEditingController search = TextEditingController();

  List forecast = [];

  var weather;
  var citySearched;

  getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    citySearched = prefs.getString('citySearched');
    citySearched == null ? getWeather("mumbai") : getWeather(citySearched);
  }

  getWeather(String city) async {
    weather = await service.getWeather(city);
    FocusScope.of(context).unfocus();
    search.clear();
    forecast.clear();
    getForecast(weather.coord.lat, weather.coord.lon);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('citySearched', city);
  }

  getForecast(lat, lon) async {
    var forecastData = await service.getForecast(lat, lon);
    for (var i = 0; i <= 47; i++) {
      forecast.add(forecastData);
    }
    setState(() {});
  }

  @override
  void initState() {
    getCity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: weather == null ? Text('Loading...') : Text(weather.name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: weather == null
          ? Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(weather.background),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.hardLight,
                  ),
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
                        child: TextField(
                          controller: search,
                          style: TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.go,
                          onSubmitted: (_) {
                            getWeather(search.text);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent.withOpacity(0.5),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            prefixIcon: IconButton(
                              onPressed: () {
                                getWeather(search.text);
                              },
                              icon: Icon(Icons.search),
                              color: Colors.grey,
                            ),
                            hintText: "Search city...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: weather.main.temp.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: Offset(0, -38),
                                  child: Text(
                                    '°C',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.network(weather.icon),
                      ),
                      SizedBox(height: 5),
                      Text(
                        weather.weather.first.description
                                .toString()
                                .toUpperCase()[0] +
                            weather.weather.first.description
                                .toString()
                                .substring(1),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 40, 15, 5),
                        child: Card(
                          color: Colors.transparent.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/wind.png',
                                      height: 35,
                                      width: 35,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      (weather.wind.speed * 3.6)
                                              .toStringAsFixed(1) +
                                          " km/h",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Wind",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/drop.png',
                                      height: 35,
                                      width: 35,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      weather.main.humidity.toString() + "%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Humidity",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/weather.png',
                                      height: 35,
                                      width: 35,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      weather.main.feelsLike.toString() + "°",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Feels like",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                            itemCount: forecast.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return HourlyTile(
                                  timezone: forecast[0].timezone,
                                  dt: forecast[index].hourly[index].dt,
                                  temp: forecast[index].hourly[index].temp,
                                  main: forecast[index].hourly[index].main);
                            },
                          ),
                        ),
                      ),
                      forecast.length == 0
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 40),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.transparent.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ListView.builder(
                                  itemCount: 7,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return DailyTile(
                                        dt: forecast[index].daily[index].dt,
                                        min: forecast[index]
                                            .daily[index]
                                            .temp
                                            .min,
                                        max: forecast[index]
                                            .daily[index]
                                            .temp
                                            .max,
                                        main:
                                            forecast[index].daily[index].main);
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
