import 'package:flutter/material.dart';
import 'api_services.dart';

class CariMakananScreen extends StatefulWidget {
  @override
  _CariMakananScreenState createState() => _CariMakananScreenState();
}

class _CariMakananScreenState extends State<CariMakananScreen> {
  TextEditingController _queryController = TextEditingController();
  List<Map<String, dynamic>> _hasilPencarian = [];
  ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        title: Text('Cari Makanan'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 219, 169, 18),
                Color.fromARGB(255, 251, 255, 28),
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
            Container(
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
                controller: _queryController,
                decoration: InputDecoration(
                  labelText: 'Cari Makanan',
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cariMakanan();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 1, 1, 1),
              ),
              child: Text('Cari'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _hasilPencarian.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_hasilPencarian[index]['label']),
                    subtitle: Text('Calories: ${_hasilPencarian[index]['calories']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cariMakanan() async {
    try {
      String query = _queryController.text;
      List<Map<String, dynamic>> hasilPencarian = await _apiService.searchFood(query);
      setState(() {
        _hasilPencarian = hasilPencarian;
      });
    } catch (err) {
      print('Error: $err');
      // Handle error
    }
  }
}
