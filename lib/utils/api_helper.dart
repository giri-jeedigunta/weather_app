import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper(this.url);

  final String url;

  Future getResponse() async {
    http.Response response = await http.get(url);
    return response.statusCode == 200 ? jsonDecode(response.body) : response.statusCode;
  }
}
