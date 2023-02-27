import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'newPage2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: "PlayfairDisplay"),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<dynamic> getLocationData() async {
  Location location = Location();
  String lat;
  String lon;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  //Location için servis ayakta mı?
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  //konum izni kontrolü
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();

    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  //izinler tamamsa
  _locationData = await location.getLocation();
  Map<String, dynamic> map = {};
  map["lat"] = _locationData.latitude;
  map["lon"] = _locationData.longitude;

  lat = _locationData.latitude.toString();
  lon = _locationData.longitude.toString();

  return _locationData;
}

Future<List<dynamic>> getWeather() async {
  String apiKey = "8655f1b6f9329f29c5a130067027aaa6";
  var locations = await getLocationData();
  var lati, longi;
  if (locations != null) {
    lati = locations.latitude.toString();
    longi = locations.longitude.toString();
  }

  var durum; //bulutlu
  var sicaklik; // 12 derece
  var response; //json verileri
  var cityName; //bayat
  var countryName; // Türkiye
  var feelsLike; // hissedilen sıcaklık
  var tempMin; //minimum sıcaklık
  var tempMax; //maximum sıcaklık
  var humidity; //nem
  var wind; // rüzgar hızı

  getLocationData().then((value) {});
  response = await get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=${lati}&lon=${longi}&appid=${apiKey}&units=metric"));

  if (response.statusCode == 200) {
    String data = response.body;

    var currentWeather = jsonDecode(data);

    durum = currentWeather["weather"][0]["main"];
    sicaklik = currentWeather["main"]["temp"];
    cityName = currentWeather["name"];
    countryName = currentWeather["sys"]["country"];
    feelsLike = currentWeather["main"]["feels_like"];
    tempMin = currentWeather["main"]["temp_min"];
    tempMax = currentWeather["main"]["temp_max"];
    humidity = currentWeather["main"]["humidity"];
    wind = currentWeather["wind"]["speed"];
  } else {
    print("apiden değer gelmiyor");
  }

  var liste = [
    durum,
    sicaklik,
    cityName,
    countryName,
    feelsLike,
    tempMin,
    tempMax,
    humidity,
    wind
  ];

  return liste;
}

var spinkit = SpinKitThreeInOut(
  itemBuilder: (BuildContext context, int index) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
    );
  },
);

class _MyHomePageState extends State<MyHomePage> {
  var a;
  var b;
  var c;
  var d;
  var e;
  var f;
  var g;
  var h;
  var i;
//tek tek hepsini yaz
//butona tıklanınca bu değişkenlere atansın
//sonra diğer sayfaya atla değerleri gönder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 280, 100, 50),
              child: FloatingActionButton.extended(
                backgroundColor: Color.fromARGB(255, 128, 128, 128),
                onPressed: () {
                  getWeather().then((value) {
                    setState(() {
                      a = value[0];
                      b = value[1];
                      c = value[2];
                      d = value[3];
                      e = value[4];
                      f = value[5];
                      g = value[6];
                      h = value[7];
                      i = value[8];
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                newPage2(a, b, c, d, e, f, g, h, i)));
                  });
                },
                label: Text("Hava Durumu"),
                icon: Icon(Icons.login),
              ),
            ),
            spinkit,
          ],
        ),
      ),
    );
  }
}
