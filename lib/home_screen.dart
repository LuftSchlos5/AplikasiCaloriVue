import 'package:flutter/material.dart';
import 'package:flutter_tubes/bmi_calc.dart';
import 'package:flutter_tubes/cari_makanan.dart';
import 'package:flutter_tubes/data_pengguna.dart';
import 'package:flutter_tubes/catatan_kalori.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/2316/2316949.png',
              width: 40,
              height: 40,
            ),
            SizedBox(width: 10),
            Text(
              'Penghitung Kalori',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade400,
                Colors.purple.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            FeatureButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BMICalculatorScreen()),
                );
              },
              imageNetwork:
                  "https://cdn-icons-png.flaticon.com/512/3373/3373118.png",
              title: 'BMI Calculator',
              description: 'Hitung Indeks Massa Tubuh Anda',
              buttonColor: Colors.teal.shade400,
              imageSize: 50,
            ),
            SizedBox(height: 20),
            FeatureButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CariMakananScreen()),
                );
              },
              imageNetwork:
                  "https://icons.veryicon.com/png/o/commerce-shopping/small-icons-with-highlights/search-260.png",
              title: 'Cari Makanan',
              description: 'Temukan informasi nutrisi makanan',
              buttonColor: Colors.amber.shade400,
              imageSize: 50,
            ),
            SizedBox(height: 20),
            FeatureButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataPenggunaScreen()),
                );
              },
              imageNetwork:
                  "https://cdn0.iconfinder.com/data/icons/people-lifestyle/100/Walk-01-512.png",
              title: 'Hitung Kebutuhan Kalori',
              description: 'Hitung kalori yang anda butuhkan',
              buttonColor: Colors.deepOrange.shade400,
              imageSize: 50,
            ),
            SizedBox(height: 20),
            FeatureButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatatanKaloriScreen()),
                );
              },
              imageNetwork:
                  "https://img.icons8.com/?size=50&id=12581&format=png",
              title: 'Catatan Kalori',
              description: 'Catat kalori asupan anda',
              buttonColor: Color.fromARGB(255, 95, 226, 59),
              imageSize: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageNetwork;
  final String title;
  final String description;
  final Color buttonColor;
  final double imageSize;

  const FeatureButton({
    Key? key,
    required this.onPressed,
    required this.imageNetwork,
    required this.title,
    required this.description,
    required this.buttonColor,
    required this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              imageNetwork,
              width: imageSize,
              height: imageSize,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
