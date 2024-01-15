import 'package:flutter/material.dart';
import 'api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatatanKaloriScreen extends StatefulWidget {
  @override
  _CatatanKaloriScreenState createState() => _CatatanKaloriScreenState();
}

class _CatatanKaloriScreenState extends State<CatatanKaloriScreen> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> makananList = [];
  List<Map<String, dynamic>> hasilPencarian = [];

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        title: Text('Catatan Kalori Harian'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 59, 206, 59),
                Color.fromARGB(255, 50, 206, 167),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Cari Makanan',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await _pilihMakanan();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Pilih Makanan'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (hasilPencarian.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil Pencarian:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildPencarianList(hasilPencarian),
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'Makanan yang Dikonsumsi:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: makananList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(makananList[index]['label']),
                      subtitle: Text(
                        'Kalori: ${makananList[index]['calories']}',
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              _buildTotalKaloriFutureBuilder(
                label: 'Total Kalori Hari Ini',
                future: _hitungTotalKalori(),
                color: Colors.blue.shade400,
              ),
              _buildTotalKaloriFutureBuilder(
                label: 'Total Kalori Target',
                future: _hitungTotalKaloriTarget(),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalKaloriFutureBuilder(
      {required String label, required Future<double> future, required Color color}) {
    return FutureBuilder<double>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text(
            '$label: ${snapshot.data}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildPencarianList(List<Map<String, dynamic>> hasilPencarian) {
    return Column(
      children: hasilPencarian.map((makanan) {
        return ListTile(
          title: Text(
            makanan['label'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Kalori: ${makanan['calories']}',
          ),
          trailing: ElevatedButton(
            onPressed: () {
              setState(() {
                makananList.add(makanan);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 72, 72),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Tambah'),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _pilihMakanan() async {
    try {
      final List<Map<String, dynamic>> hasilPencarianBaru =
          await apiService.searchFood(_searchController.text);

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Pilih Makanan',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: hasilPencarianBaru.length,
                itemBuilder: (BuildContext context, int index) {
                  final makanan = hasilPencarianBaru[index];
                  return ListTile(
                    title: Text(
                      makanan['label'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Kalori: ${makanan['calories']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          makananList.add(makanan);
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 255, 40, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('Tambah'),
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tutup'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Gagal memuat data makanan. Silakan coba lagi.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<double> _hitungTotalKalori() async {
    double totalKalori = 0;

    for (var makanan in makananList) {
      totalKalori += makanan['calories'];
    }

    return totalKalori;
  }

  Future<double> _hitungTotalKaloriTarget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double totalKaloriTarget = prefs.getDouble('totalKaloriTarget') ?? 0;
    return totalKaloriTarget;
  }
}
