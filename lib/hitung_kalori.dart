import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HitungKaloriScreen extends StatefulWidget {
  final double tinggi;
  final double berat;
  final double targetBerat;
  final String jenisKelamin;
  final String nama;
  final int umur;

  HitungKaloriScreen({
    required this.tinggi,
    required this.berat,
    required this.targetBerat,
    required this.jenisKelamin,
    required this.nama,
    required this.umur,
  });

  @override
  _HitungKaloriScreenState createState() => _HitungKaloriScreenState();
}

class _HitungKaloriScreenState extends State<HitungKaloriScreen> {
  double totalKaloriHarian = 0;
  double totalKaloriTarget = 0;

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  void loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      totalKaloriHarian = prefs.getDouble('totalKaloriHarian') ?? 0;
      totalKaloriTarget = prefs.getDouble('totalKaloriTarget') ?? 0;

      // Setelah menetapkan nilai awal, hitung kalori
      calculateKalori();
    });
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('totalKaloriHarian', totalKaloriHarian);
    prefs.setDouble('totalKaloriTarget', totalKaloriTarget);
  }

  @override
  void dispose() {
    saveData();
    super.dispose();
  }

  void calculateKalori() {
    double totalKaloriHarian = hitungKalori(
      widget.tinggi,
      widget.berat,
      widget.jenisKelamin,
      widget.umur,
    );

    double totalKaloriTarget = hitungKalori(
      widget.tinggi,
      widget.targetBerat,
      widget.jenisKelamin,
      widget.umur,
    );

    updateState(totalKaloriHarian, totalKaloriTarget);
  }

  void updateState(double totalKaloriHarian, double totalKaloriTarget) {
    setState(() {
      this.totalKaloriHarian = totalKaloriHarian;
      this.totalKaloriTarget = totalKaloriTarget;
    });
  }

  void simpanData() {
    print(
        'Simpan data: ${widget.nama}, Total Kalori Harian: $totalKaloriHarian, Total Kalori Target: $totalKaloriTarget');
    showSnackbar('Data telah disimpan');
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        title: Text('Hasil Perhitungan Kalori'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 198, 63, 63),
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
        child: ListView(
          children: [
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Hasil Perhitungan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 250, 97, 15),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    buildResultItem('Nama', widget.nama),
                    buildResultItem('Umur', '${widget.umur} tahun'),
                    buildResultItem('Jenis Kelamin', widget.jenisKelamin),
                    buildResultItem('Tinggi Badan', '${widget.tinggi} cm'),
                    buildResultItem('Berat Badan', '${widget.berat} kg'),
                    buildResultItem(
                        'Target Berat Badan', '${widget.targetBerat} kg'),
                    SizedBox(height: 10),
                    buildResultItem('Total Kalori Harian',
                        '${totalKaloriHarian.toStringAsFixed(2)} kkal'),
                    buildResultItem('Total Kalori Target',
                        '${totalKaloriTarget.toStringAsFixed(2)} kkal'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                simpanData();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Simpan Hasil',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  double hitungKalori(
      double tinggi, double berat, String jenisKelamin, int umur) {
    double bmr;

    if (jenisKelamin == 'Laki-laki') {
      bmr = 66.5 + (13.75 * berat) + (5.003 * tinggi) - (6.75 * umur);
    } else {
      bmr = 655.1 + (9.563 * berat) + (1.850 * tinggi) - (4.676 * umur);
    }

    double aktivitasFisik = 1.55;
    double kaloriTotal = bmr * aktivitasFisik;

    return kaloriTotal;
  }
}
