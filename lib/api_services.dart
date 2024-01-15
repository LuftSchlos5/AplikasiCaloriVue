import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String appId = 'a46e6b97';
  final String apiKey = '5571f2d80d2d1fdc1605ae42cf150f53';

  Future<List<Map<String, dynamic>>> searchFood(String query) async {
    try {
      final String endpoint =
          'https://api.edamam.com/api/food-database/v2/parser?ingr=$query&app_id=$appId&app_key=$apiKey';

      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['hints'] != null) {
          List<Map<String, dynamic>> searchResults =
              List<Map<String, dynamic>>.from(data['hints']).map((hint) {
            final food = hint['food'];
            return {
              'label': food['label'],
              'calories': food['nutrients']['ENERC_KCAL'],
            };
          }).toList();

          return searchResults;
        } else {
          // Data tidak ditemukan
          return [];
        }
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred');
    }
  }
}
