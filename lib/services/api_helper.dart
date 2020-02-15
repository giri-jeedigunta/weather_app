import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelperService {
  ApiHelperService(this.url);

  final String url;

  Future getResponse() async {
    final response = await http.get(url);
    return response.statusCode == 200 ? jsonDecode(response.body) : null;
  }
}
