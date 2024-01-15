import 'package:flutter/material.dart';
import 'package:flutter_tubes/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 116, 137, 173), // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [const Color.fromARGB(255, 155, 201, 238), Color.fromARGB(255, 255, 254, 207)]    
                  )
              ),
              padding: EdgeInsets.all(20),
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/512/2316/2316949.png",
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Penghitung Kalori",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
