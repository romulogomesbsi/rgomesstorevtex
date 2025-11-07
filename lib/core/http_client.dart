import 'package:http/http.dart' as http;

class HttpClient {
  static const _baseUrl =
      'https://storecomponents.vtexcommercestable.com.br/api';

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    return await http.get(url, headers: _headers);
  }
}
