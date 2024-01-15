import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController tinggiController = TextEditingController();
  TextEditingController beratController = TextEditingController();
  String jenisKelamin = 'Laki-laki';
  String hasilBMI = '';
  String deskripsiBMI = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        title: Row(
          children: [
            Icon(Icons.calculate),
            SizedBox(width: 10),
            Text('BMI Calculator'),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade400,
                Color.fromARGB(255, 49, 199, 149),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: jenisKelamin,
                onChanged: (String? newValue) {
                  setState(() {
                    jenisKelamin = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(),
                ),
                items: <String>['Laki-laki', 'Perempuan']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: tinggiController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tinggi (cm)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: beratController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Berat (kg)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  hitungBMI();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 0, 0, 0),
                ),
                child: Text('Hitung BMI'),
              ),
              SizedBox(height: 40),
              Card(
                color: Colors.white70,
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Hasil BMI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$hasilBMI',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$deskripsiBMI',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void hitungBMI() {
    try {
      double tinggi = double.parse(tinggiController.text);
      double berat = double.parse(beratController.text);

      double bmi = berat / ((tinggi / 100) * (tinggi / 100));

      setState(() {
        hasilBMI = bmi.toStringAsFixed(2);
        deskripsiBMI = getDeskripsiBMI(bmi);
      });
    } catch (e) {
      print('Error calculating BMI: $e');
      setState(() {
        hasilBMI = 'Error';
        deskripsiBMI = '';
      });
    }
  }

  String getDeskripsiBMI(double bmi) {
    if (bmi < 18.5) {
      return 'Berat badan kurang, sebaiknya konsultasikan dengan dokter atau ahli gizi.';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Berat badan normal, pertahankan pola hidup sehat!';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Berat badan berlebih, pertahankan pola makan sehat dan rajin berolahraga.';
    } else if (bmi >= 30) {
      return 'Obesitas, sebaiknya konsultasikan dengan dokter atau ahli gizi.';
    } else {
      return '';
    }
  }
}
