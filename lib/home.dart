import 'package:flutter/material.dart';
import 'service.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController search = TextEditingController();
  Service service = Service();
  var weather;

  @override
  void initState() {
    getWeather("mumbai");
    super.initState();
  }

  getWeather(String city) async {
    final weatherData = await service.getWeather(city);
    setState(() {
      weather = weatherData;
    });
    search.clear();
  }

  @override
  Widget build(BuildContext context) {
    return weather == null ?
    Container(
      color: Colors.black,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ) :
    Scaffold(
      appBar: AppBar(
        title: Text(weather.cityName,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
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
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.hardLight),
          )
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15,20,15,5),
                  child: TextField(
                    controller: search,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (_){
                      getWeather(search.text);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent.withAlpha(60),
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
                      suffixIcon: IconButton(
                        onPressed: (){
                          getWeather(search.text);
                        },
                        icon: Icon(Icons.search),
                        iconSize: 30,
                        color: Colors.white,
                      ),
                      hintText: "Search city...",
                      hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20,30,20,2),
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: weather.temperatureInfo.temp.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 110, fontWeight: FontWeight.bold),
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: Offset(0, -40),
                              child: Text('°C',
                                style: TextStyle(color: Colors.white,fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                ),
                Image.network(weather.icon),
                Text(weather.weatherInfo.desc.toString().toUpperCase()[0] + weather.weatherInfo.desc.toString().substring(1),
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.fromLTRB(20,0,20,0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,20,0,20),
                    decoration: BoxDecoration(
                      color: Colors.transparent.withAlpha(80),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Text("Real feel",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
                                ),
                                SizedBox(height: 10),
                                Text(weather.temperatureInfo.feels.toString() + "°C",
                                  style: TextStyle(color: Colors.white, fontSize: 22),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Column(
                              children: [
                                Text("Humidity",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
                                ),
                                SizedBox(height: 10),
                                Text(weather.temperatureInfo.humidity.toString() + "%",
                                  style: TextStyle(color: Colors.white, fontSize: 22),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                Text("Pressure",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
                                ),
                                SizedBox(height: 10),
                                Text(weather.temperatureInfo.pressure.toString() + "mbar",
                                  style: TextStyle(color: Colors.white, fontSize: 22),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Column(
                              children: [
                                Text("Wind speed",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
                                ),
                                SizedBox(height: 10),
                                Text(weather.windInfo.speed.toString() + "m/s",
                                  style: TextStyle(color: Colors.white, fontSize: 22),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}