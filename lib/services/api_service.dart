import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> sendMeasurementData(
      File front, File side, String height) async {
    var uri = Uri.parse("http://localhost:12345/me/");

    var request = http.MultipartRequest("POST", uri)
      ..fields['height'] = height
      ..files.add(await http.MultipartFile.fromPath('front_image', front.path))
      ..files.add(await http.MultipartFile.fromPath('side_image', side.path));

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      throw Exception("Failed to get response");
    }
  }
}
