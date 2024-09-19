import '../constants/components.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/strings.dart';


class ApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';


  static const upcomingMovies = "/movie/upcoming?api_key=$apiKey";

  static Future<Map<String, dynamic>?> getRequest(String endPoint ) async {
    // var token = await StorageUtil.getData(StorageUtil.keyToken);
    Map<String, String> header = <String, String>{};
    header.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });
    // if (token != null) {
    //   header.addAll({
    //     'Authorization': 'Bearer $token',
    //   });
    // }
    final url = Uri.parse('$_baseUrl$endPoint');
    final response = await http.get(url);

    print("ApiService GET Api: $url");
    print("ApiService Api Header: $header");
    if (response.statusCode == 200) {
      print("ApiService GET Response Code : ${response.statusCode} of $endPoint");
      print("ApiService GET Response : ${json.decode(response.body)}");
      return jsonDecode(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 403 || response.statusCode == 500) {
      print("ApiService GET Error Response Code : ${response.statusCode}");
      showSnackBar(msgSomethingWentWrong);
    } else {
      openAndCloseLoadingDialog(false);
      print("ApiService GET Error Response Code : ${response.statusCode}");
        showSnackBar(msgSomethingWentWrong);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> postRequest(String endPoint, Object data,Function? onError) async {
    // var token = await StorageUtil.getData(StorageUtil.keyToken);
    Map<String, String> header = <String, String>{};
    header.addAll({'Accept': 'application/json', 'Content-Type': 'application/json'});
    // if (token != null) {
    //   header.addAll({
    //     'Authorization': 'Bearer $token',
    //   });
    // }
    // final url = Uri.parse('$_baseUrl$endPoint');
    final url = Uri.parse(endPoint);
    final body = jsonEncode(data);

    final response = await http.post(Uri.parse(endPoint), headers: header, body: body);
    print("ApiService Post Response Code : ${response.statusCode}");
    print("ApiService Post Response url : ${url}");
    print("ApiService Post Response : ${json.decode(response.body)}");
    if (response.statusCode == 200) {
      print("ApiService Post Response url : ${response.statusCode}");

      return jsonDecode(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 403 || response.statusCode == 500) {
      showSnackBar(msgSomethingWentWrong);
    }
    else {
      openAndCloseLoadingDialog(false);
        showSnackBar(msgSomethingWentWrong);
    }
    return null;
  }
}