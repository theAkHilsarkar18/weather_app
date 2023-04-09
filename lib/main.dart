import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/homescreen/provider/weatherprovider.dart';
import 'package:weather_app/screens/homescreen/view/weatherscreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Weatherprovider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Splashscreen(),
          'weather': (context) => Weatherscreen(),
        },
      ),
    ),
  );
}

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    Weatherprovider weatherproviderTrue = Provider.of(context, listen: true);
    Weatherprovider weatherproviderFalse = Provider.of(context, listen: false);

    Timer(Duration(seconds: 8), () {Navigator.pushReplacementNamed(context, 'weather'); });

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Spacer(),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade600,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(borderRadius: BorderRadiusDirectional.circular(200),child: Image.asset("assets/day/logo.gif",fit: BoxFit.cover,)),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("by TheAkhilSarkar & ",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.blueGrey.shade800)),
                  Icon(Icons.all_inclusive,color: Colors.blueGrey.shade800,),
                ],
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
