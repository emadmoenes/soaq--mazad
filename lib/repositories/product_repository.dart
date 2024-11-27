import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  final String baseUrl;

  ProductRepository({required this.baseUrl});

  Future<List<Product>> fetchProducts(
      {required int startIndex, required int limit}) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/products?start=$startIndex&limit=$limit'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
