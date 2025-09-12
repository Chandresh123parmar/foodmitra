import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screen/splash_Screen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resturent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}



/* Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade400)
            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                        //height: height,
                        decoration: BoxDecoration(
                            color: Colors.white,
                          border: Border.all(color: Colors.black)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            text(
                                title,
                                fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                            text(
                                'Phone No : $phone_NO',
                                fontSize: 13 ,
                                fontWeight: FontWeight.bold
                            ),
                            Row(
                              children: [
                                text(
                                    'Name:',
                                    fontSize: 13 ,
                                    fontWeight: FontWeight.bold
                                ),
                                SizedBox(width: 200,),
                                text(
                                    'Date:',
                                    fontSize: 13 ,
                                    fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                text(
                                    'Address:',
                                    fontSize: 13 ,
                                    fontWeight: FontWeight.bold
                                ),
                                SizedBox(width: 122,),
                                text(
                                    'People No:',
                                    fontSize: 13 ,
                                    fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                            Row(
                              spacing: 48,
                              children: [
                                text(
                                    'Phone:',
                                    fontSize: 13 ,
                                    fontWeight: FontWeight.bold
                                ),
                                text(
                                    'Shift:',
                                    fontSize: 13 ,
                                    fontWeight: FontWeight.bold
                                ),
                                text(
                                    'Price:',
                                    fontSize: 13 ,
                                    fontWeight: FontWeight.bold
                                ),
                              ],
                            )
                          ],
                        )
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green.shade400)
                      ),
                      child: Text(widget.categoryName),
                    )
                  ],
                ),
              ),
            ),

          ),
        ],
      )*/