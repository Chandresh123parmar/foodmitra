import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodmitra/utils/FoodImages.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';
import '../utils/FoodColors.dart';
import 'BottomBarNavigatorScreen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {


  final MovieTween tween = MovieTween()
    ..scene(begin: Duration(milliseconds: 0), end: Duration(seconds: 1))
        .tween('scale', Tween(begin: 2.0, end: 3.5))
    ..scene(begin: Duration(milliseconds: 1000), end: Duration(seconds: 1))
        .tween('scale', Tween(begin: 2.0, end: 1.0));


  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent,statusBarColor: Colors.transparent));

    Future.delayed(Duration(seconds: 2),() async{
Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Bottombarnavigatorscreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(customColor("#334d50")),
              Color(customColor("#cbcaa5")),
            ],
          ),
        ),
        child: Image.asset(splashLogo,
            width: double.infinity,
            height: double.infinity,
            fit:BoxFit.contain),
      ),
    );
  }
}