import 'package:abrin_app_new/Home/home_Screen.dart';
import 'package:abrin_app_new/aouth/component/session_handling_provider.dart';
import 'package:abrin_app_new/aouth/login.dart';
import 'package:abrin_app_new/componets/modelCategories.dart';
import 'package:flutter/material.dart';


class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    // Delay navigation by 3 seconds
    Future.delayed(Duration(seconds: 3), () async {
      // Navigate to your desired screen
      final token = await SessionHandlingViewModel().getToken();
      print("::: the token in splash is :$token");
      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(categories: categories,)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Color(0xff3598DB),
        child: Center(
            child: Image.asset(
          'assets/appIcon.png',
          width: double.infinity,
          height:double.infinity,
        )),
      ),
    );
  }
}
