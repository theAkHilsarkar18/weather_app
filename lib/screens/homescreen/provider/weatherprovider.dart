import 'package:flutter/material.dart';
import 'package:weather_app/screens/homescreen/model/weathermodel.dart';
import 'package:weather_app/utils/apihelper/weatherhelper.dart';

class Weatherprovider extends ChangeNotifier
{
  String sunny = "https://thumbs.gfycat.com/FlawedDistantBrocketdeer-size_restricted.gif";
  String moon = "https://i.pinimg.com/originals/3b/c1/9f/3bc19f1fbac37622e3f635f9b49fa8fe.gif";
  String cloudy = "https://thumbs.gfycat.com/RapidDimEider-max-1mb.gif";
  String rainy = "https://i.pinimg.com/originals/c4/f0/ca/c4f0cab9867d92dca145418eeabcf03a.gif";

  String nightBg = "https://i.pinimg.com/originals/96/df/d4/96dfd411ab0e68f8bc1eb47e4eee8771.gif";
  String sunrise = "https://i.pinimg.com/originals/2b/a3/ab/2ba3ab0eb7ebc7ed5ab14f60f504c2ce.gif";
  String sunset = "https://i.pinimg.com/originals/2b/a3/ab/2ba3ab0eb7ebc7ed5ab14f60f504c2ce.gif";
  String day = "https://i.pinimg.com/originals/da/97/8f/da978f6b8ee61f6af712a6b4698fc706.gif";
  String beforeSunrise = "https://media.tenor.com/y7_bLRuZ0PMAAAAd/weather.gif";
  String afterSunrise = "https://media.tenor.com/y7_bLRuZ0PMAAAAd/weather.gif";

  String logo = "https://i.pinimg.com/originals/0e/f3/bb/0ef3bb66d9216fffcea9022628f7bb26.gif";

  String location = "surat";
  Weathermodel? weathermodel;
  Future<Weathermodel?> weatherJsonParshing(String location)
  async {
    weathermodel = await WeatherApiHelper().weatherApiCalling(location);
    return weathermodel;
    notifyListeners();
  }

  void changeLocation(String newLocation)
  {
    location = newLocation;
    notifyListeners();
  }


}