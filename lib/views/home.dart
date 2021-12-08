import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather/service/service.dart';
import 'daily_tile.dart';
import 'hourly_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var weather;
  var citySearched;
  List forecast = [];
  TextEditingController search = TextEditingController();
  Service service = Service();

  getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    citySearched = prefs.getString('citySearched');
    citySearched == null ? getWeather("mumbai") : getWeather(citySearched);
  }

  getWeather(String city) async {
    final weatherData = await service.getWeather(city);
    setState(() {
      weather = weatherData;
    });
    FocusScope.of(context).unfocus();
    search.clear();
    forecast.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('citySearched', city);
    getForecast(weather.coordInfo.lat, weather.coordInfo.lon);
  }

  getForecast(lat, lon) async {
    var forecastData = await service.getForecast(lat, lon);
    for(var i = 0; i <= 47; i++) {
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
    return weather == null ?
    Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('Loading...',
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15,20,15,5),
                child: TextField(
                  readOnly: true,
                  controller: search,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent.withAlpha(60),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Search city...",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10,20,10,40),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.transparent.withAlpha(80),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ) :
    Scaffold(
      appBar: AppBar(
        title: Text(weather.cityName,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
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
          )
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15,20,15,5),
                  child: TextField(
                    controller: search,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (_){
                      getWeather(search.text);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent.withOpacity(0.5),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: IconButton(
                        onPressed: (){
                          getWeather(search.text);
                        },
                        icon: Icon(Icons.search),
                        color: Colors.grey,
                      ),
                      hintText: "Search city...",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20,80,20,10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: weather.temperatureInfo.temp.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 110,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: Offset(0, -40),
                            child: Text('°C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
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
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Image.network(weather.icon),
                ),
                SizedBox(height: 5),
                Text(weather.weatherInfo.desc.toString().toUpperCase()[0] + weather.weatherInfo.desc.toString().substring(1),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15,50,15,5),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,15,0,15),
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/images/wind.png',
                              height: 35,
                              width: 35,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 5),
                            Text((weather.windInfo.speed * 3.6).toString() + "km/h",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            Text("Wind",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset('assets/images/drop.png',
                              height: 35,
                              width: 35,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 5),
                            Text(weather.temperatureInfo.humidity.toString() + "%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            Text("Humidity",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset('assets/images/weather.png',
                              height: 35,
                              width: 35,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 5),
                            Text(weather.temperatureInfo.feels.toString() + "°",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            Text("Real feel",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10,10,10,0),
                  child: Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: forecast.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return HourlyTile(
                          timezone: forecast[0].timezone,
                          dt: forecast[index].hourly[index].dt,
                          temp: forecast[index].hourly[index].temp,
                          icon: forecast[index].hourly[index].icons,
                          main: forecast[index].hourly[index].main,
                        );
                      },
                    ),
                  ),
                ),
                forecast.length == 0
                ? Container()
                : Padding(
                  padding: EdgeInsets.fromLTRB(10,5,10,40),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListView.builder(
                      itemCount: 7,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return DailyTile(
                          dt: forecast[index].daily[index].dt,
                          min: forecast[index].daily[index].temp.min,
                          max: forecast[index].daily[index].temp.max,
                          main: forecast[index].daily[index].main,
                          icon: forecast[index].daily[index].icons,
                        );
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