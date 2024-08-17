import 'package:abrin_app_new/BookMark/BMProvider.dart';
import 'package:abrin_app_new/Home/home_Screen.dart';
import 'package:abrin_app_new/RetriveToken.dart';
import 'package:abrin_app_new/Search/provider.dart';
import 'package:abrin_app_new/aouth/component/session_handling_provider.dart';
import 'package:abrin_app_new/aouth/login.dart';
import 'package:abrin_app_new/aouth/splash_screen.dart';
import 'package:abrin_app_new/componets/modelCategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'aouth/Handlers/aouthProviderSignup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(
          create: (_) => BookmarkProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => SessionHandlingViewModel(),
        ),
      ],
      // ChangeNotifierProvider(
      //   create: (ctx) => AuthProvider(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Signup Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:SplasScreen(),
        //  FutureBuilder<String?>(
          
        //   future: SessionHandlingViewModel().getToken(),
        //   builder: (context, snapshot) {
        //     print("::: the token fromm session:${SessionHandlingViewModel().getToken()}");
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Scaffold(
        //         body: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     } else if (snapshot.hasData && snapshot.data != null) {
        //       return HomeScreen(
        //           categories: categories); // Navigate to home if token exists
        //     } else {
        //       return LoginPage(); // Navigate to login if no token found
        //     }
        //   },
        // ),
      ),
    );
  }
}
/////////////////////////////////new project//////////////
//////////////////////new/////////////