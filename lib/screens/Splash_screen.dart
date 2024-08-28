import 'package:flutter/material.dart';
import 'package:loginstudent/screens/icode_verification_screen.dart';
import 'package:screen_protector/screen_protector.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    avoidScreenshot();
    super.initState();
  }

  avoidScreenshot() async {
    await ScreenProtector
        .preventScreenshotOn(); //Disable ScreenShot and Screen recording
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(

      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Text(
              'Edu Influx School',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: "MainFont",
                  color: Colors.black),
            ),
            SizedBox(
              height: height / 25,
            ),
            const Text(
              'Welcome To Edu School',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: "MainFont"),
            ),
            const Spacer(),
            //const SizedBox(height: 50),
            Image.asset(
              "assets/logo1.png",
              width: width / 2,
              height: height / 4,
            ),
            SizedBox(
              height: height / 5,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ICodeVerificationScreen()),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height / 55, horizontal: height / 8),
                child: const Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "MainFont"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
