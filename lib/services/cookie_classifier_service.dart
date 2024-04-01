import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;
import "package:http/http.dart";

const String apiEndpoint = "http://192.168.1.68:8000";

Future<String> classifyCookie(File imageFile) async {
  final url = Uri.parse('$apiEndpoint/cookie-classifier'); // Replace with your server URL

  final request = MultipartRequest('POST', url);
  request.files.add(
    MultipartFile.fromBytes(
      'image',
      imageFile.readAsBytesSync(),
      filename: 'cookie.jpg',
    ),
  );


  final streamedResponse = await request.send();

  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data['cookie_type'];
  } else {
    throw Exception('Failed to classify cookie');
  }

}