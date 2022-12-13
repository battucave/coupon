import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logan/constant/api_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class NetWorkHandler {
  static final client = http.Client();

  Map<String, String> headers = {"content-type": "application/json"};
  Map<String, String> multipardHeaders = {"Accesstoken": "access_token"};

  static Future<http.Response> post(var body, String endpoint) async {
    http.Response response = await client.post(buildUrl(endpoint),
        body: body, headers: {"Content-type": "application/json"});

    return response;
  }

  Future<http.Response> postWithAuthorization(var body, String endpoint) async {
    await setHeaderToken();
    http.Response response =
        await client.post(buildUrl(endpoint), body: body, headers: headers);

    return response;
  }

  Future<http.Response> postWithParameters(
      var body, String endpoint, String resetToken) async {
    print(body);
    http.Response response = await client.post(
        buildUrlWithStringParameters(endpoint, resetToken),
        body: body,
        headers: headers);

    return response;
  }

  static Future<http.Response> postFormData(Map body, String endpoint) async {
    http.Response response =
        await client.post(buildUrl(endpoint), body: body, headers: {
      'contentType': 'multipart/form-data',
    });
    return response;
  }

  setHeaderToken() async {
    String? token = await NetWorkHandler.getToken();
    headers.putIfAbsent('Authorization', () => 'Bearer $token');
  }

  Future<http.Response> patch(var body, String endpoint) async {
    await setHeaderToken();
    http.Response response =
        await client.patch(buildUrl(endpoint), body: body, headers: headers);
    return response;
  }

  Future<http.Response> get(String endpoint) async {
    await setHeaderToken();
    http.Response response =
        await client.get(buildUrl(endpoint), headers: headers);
    return response;
  }

  Future<http.Response> getWithParameters(
      String endpoint, int param, bool paramIsAtEnd) async {
    await setHeaderToken();
    http.Response response = await client.get(
        buildUrlWithParameters(endpoint, param, paramIsAtEnd),
        headers: headers);
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    await setHeaderToken();
    http.Response response =
        await client.delete(buildUrl(endpoint), headers: headers);
    return response;
  }

  Future<http.StreamedResponse> postMultipartRequest(
      String filepath, url, String endpoint) async {
    String? token = await getToken();
    int? userId = await getUserId();
    http.MultipartRequest request = await http.MultipartRequest(
      'POST',
      Uri.parse(ApiRoutes.apiHost + endpoint + "?id=${userId}"),
    );
    request.headers["content-type"] = "multipart/form-data";
    request.headers["authorization"] = "Bearer ${token!}";
    request.files.add(
      await http.MultipartFile('file', File(filepath).readAsBytes().asStream(),
          File(filepath).lengthSync(),
          filename: filepath.split("/").last),
    );
    http.StreamedResponse res = await request.send();
    return res;
  }

  Future<http.Response> patchMultipartRequestt(
      String filepath, url, String endpoint) async {
    String? token = await getToken();
    int? userId = await getUserId();
    await setHeaderToken();
    http.Response request = await post(
      File(filepath).readAsBytes().asStream(),
      endpoint + "?id=${userId}",
    );

    return request;
  }

  //Subscription
  Future<http.Response> getSubscription(String endpoint) async {
    // String? token = await getToken();
    int? userId = await getUserId();
    log('USERID:: $userId');
    await setHeaderToken();
    http.Response request = await get('$endpoint$userId');
    log('STATUS CODE:: ${request.statusCode}');
    return request;
  }

  Future<http.Response> createSubscription(
      {required String endpoint,
      required String platform,
      required String receipt}) async {
    // String? token = await getToken();
    int? userId = await getUserId();
    log('USERID:: $userId');
    await setHeaderToken();
    final body = {'user_id': userId, 'platform': platform, 'receipt': receipt};
    // http.Response request = await post(jsonEncode(body), endpoint);
    final response = await http.post(buildUrl(endpoint),
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    log('STATUS CODE:: ${response.statusCode}');
    return response;
  }

  static Uri buildUrl(String endpoint) {
    final apiPath = ApiRoutes.apiHost + endpoint;
    return Uri.parse(apiPath);
  }

  static Uri buildUrlWithParameters(
      String endpoint, int param, bool paramIsAtEnd) {
    final apiPath = !paramIsAtEnd
        ? ApiRoutes.apiHost + "api/v1/${param}/" + endpoint
        : ApiRoutes.apiHost + "${endpoint}" + param.toString();
    return Uri.parse(apiPath);
  }

  static Uri buildUrlWithStringParameters(
    String endpoint,
    String param,
  ) {
    final apiPath = ApiRoutes.apiHost + endpoint + param;
    return Uri.parse(apiPath);
  }

  static void storeToken(String token) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    log('Token:: ${prefs.getString("token")}');
    return prefs.getString("token");
  }

  static void storeUserId(int userId) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", userId);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("id");
  }
}
