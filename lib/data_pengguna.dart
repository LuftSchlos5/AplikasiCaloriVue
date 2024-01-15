import 'package:flutter/material.dart';
import 'hitung_kalori.dart';

class DataPenggunaScreen extends StatefulWidget {
  @override
  _DataPenggunaScreenState createState() => _DataPenggunaScreenState();
}

class _DataPenggunaScreenState extends State<DataPenggunaScreen> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _tanggalLahirController = TextEditingController();
  TextEditingController tinggiController = TextEditingController();
  TextEditingController beratController = TextEditingController();
  TextEditingController targetBeratController = TextEditingController();
  String jenisKelamin = 'Laki-laki';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        title: Text('Data Pengguna'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 198, 63, 63),
                const Color.fromARGB(255, 188, 71, 145),
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
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _tanggalLahirController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null && pickedDate != DateTime.now()) {
                    setState(() {
                      _tanggalLahirController.text =
                          pickedDate.toLocal().toString().split(' ')[0];
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: tinggiController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan (cm)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: beratController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Berat Badan (kg)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: targetBeratController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Target Berat Badan (kg)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.people),
                  SizedBox(width: 10),
                  Text('Jenis Kelamin:'),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: jenisKelamin,
                    onChanged: (String? newValue) {
                      setState(() {
                        jenisKelamin = newValue!;
                      });
                    },
                    items: <String>['Laki-laki', 'Perempuan']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_namaController.text.isEmpty ||
                      _tanggalLahirController.text.isEmpty ||
                      tinggiController.text.isEmpty ||
                      beratController.text.isEmpty ||
                      targetBeratController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Mohon isi semua data.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    // Hitung umur berdasarkan tanggal lahir
                    try {
                      DateTime now = DateTime.now();
                      DateTime tanggalLahir =
                          DateTime.parse(_tanggalLahirController.text);
                      int umur = now.year - tanggalLahir.year;
                      print('Umur: $umur tahun');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HitungKaloriScreen(
                            tinggi: double.parse(tinggiController.text),
                            berat: double.parse(beratController.text),
                            targetBerat:
                                double.parse(targetBeratController.text),
                            jenisKelamin: jenisKelamin,
                            nama: _namaController.text,
                            umur: umur,
                          ),
                        ),
                      );
                    } catch (e) {
                      print('Error parsing tanggal lahir: $e');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 0, 0, 0),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
