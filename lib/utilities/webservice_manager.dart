import 'dart:convert';

import 'package:http/http.dart';

class WebserviceManager {
  static String baseURL = "https://webservices.dev501ready.com/api";

  Future<Map<dynamic, dynamic>> makeGetRequest(String url) async {
    // make GET request
    String mainUrl = baseURL + '/' + url;
    Response response = await get(mainUrl);
    // sample info available in response
    int statusCode = response.statusCode;
    // print(mainUrl + ' : ${statusCode}');
    Map<String, String> headers = response.headers;
    // String contentType = headers['content-type'];
    String json = response.body;
    print('responseBody : ' + json);
    Map<dynamic, dynamic> jsonMap = jsonDecode(json);

    return jsonMap;
  }

  Future<Map<dynamic, dynamic>> makePostRequest(String url, String json) async {
    // set up POST request arguments
    String mainUrl = baseURL + '/' + url;
    Map<String, String> headers = {"Content-type": "application/form-data"};
    // make POST request
    print("json body" + json);
    Response response = await post(mainUrl, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    print(mainUrl + ' : $statusCode');
    // this API passes back the id of the new item added to the body
    String body = response.body;
    print('responseBody : ' + body);
    Map<dynamic, dynamic> bodyMap = jsonDecode(body);

    return bodyMap;
  }

  Future<Map<dynamic, dynamic>> makePostRequestMap(
      String url, var jsonMap) async {
    // set up POST request arguments
    String mainUrl = baseURL + '/' + url;
    Map<String, String> headers = {"Content-type": "application/json"};
    // make POST request
    print("json body" + jsonEncode(jsonMap));
    Response response =
        await post(mainUrl, headers: headers, body: jsonEncode(jsonMap));
    // check the status code for the result
    int statusCode = response.statusCode;
    print(mainUrl + ' : $statusCode');
    // this API passes back the id of the new item added to the body
    String body = response.body;
    print('responseBody : ' + body);
    Map<dynamic, dynamic> bodyMap = jsonDecode(body);

    return bodyMap;
  }
}
