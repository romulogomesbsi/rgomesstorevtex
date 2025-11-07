import 'dart:convert';
import 'package:http/http.dart';
import '../../core/http_client.dart';
import '../models/product_model.dart';

class VtexRemoteDataSource {
  final HttpClient client;

  VtexRemoteDataSource(this.client);

  Future<List<ProductModel>> fetchProducts() async {
    final Response response =
        await client.get('catalog_system/pub/products/search');

    if (response.statusCode == 200 || response.statusCode == 206) {
      final List data = jsonDecode(response.body);
      return data
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao buscar produtos VTEX: ${response.statusCode}');
    }
  }
}
