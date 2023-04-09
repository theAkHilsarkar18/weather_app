import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather_app/screens/homescreen/model/weathermodel.dart';
import 'package:weather_app/screens/homescreen/provider/weatherprovider.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({Key? key}) : super(key: key);

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  @override
  TextEditingController txtLocation = TextEditingController(text: "surat");


  Widget build(BuildContext context) {

    Weatherprovider weatherproviderTrue = Provider.of(context, listen: true);
    Weatherprovider weatherproviderFalse = Provider.of(context, listen: false);


    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: weatherproviderFalse.weatherJsonParshing(weatherproviderTrue.location),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              Weathermodel? weatherData = snapshot.data;
              return Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: weatherData!.current.isDay == 1
                        ? Image.network("${weatherproviderTrue.day}",
                            fit: BoxFit.cover)
                        : Image.network("${weatherproviderTrue.nightBg}",
                            fit: BoxFit
                                .cover), //Image.asset("assets/night/cloudy.jpg", fit: BoxFit.cover),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 10, right: 10),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_sharp, color: Colors.white),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${weatherData.location.name}",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 130,
                              height: 20,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      "${weatherData!.location.region}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        //fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    Text(
                                      " , ${weatherData!.location.country}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        //fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white54,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.5)),
                                            prefixIcon: Icon(Icons.location_on_sharp,color: Colors.black,)
                                          ),
                                          cursorColor: Colors.black,
                                          style: GoogleFonts.poppins(color: Colors.black,letterSpacing: 1,fontWeight: FontWeight.w500),
                                          keyboardType: TextInputType.name,
                                          controller: txtLocation,
                                          onSubmitted: (value) {

                                          },

                                        ),
                                        SizedBox(height: 20,),
                                        InkWell(
                                          onTap: () {
                                            String location = txtLocation.text;
                                            weatherproviderFalse.changeLocation(location);
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.5),
                                              borderRadius: BorderRadiusDirectional.circular(50),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text("Submit",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500)),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.share_location_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              '${weatherData.current.tempC}',
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize: 70.0,
                                  fontWeight: FontWeight.w500),
                              colors: [
                                Colors.white,
                                Colors.white70,
                                Colors.white10,
                              ],
                            ),
                            Text("o",
                                style: GoogleFonts.poppins(
                                    color: Colors.white38,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(10),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadiusDirectional.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "It's ${weatherData.current.condition.text}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Spacer(),
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: weatherData.current.isDay == 1
                                      ? Image.network(
                                          "${weatherproviderTrue.sunny}",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          "${weatherproviderTrue.moon}",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Temp. in F : ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "${weatherData.current.tempF}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Cloud : ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "${weatherData.current.cloud}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Wind spedd : ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "${weatherData.current.windKph} KmPH",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Wind degree : ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "${weatherData.current.windDegree}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Last updated : ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "${weatherData.current.lastUpdated}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
