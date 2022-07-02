


import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logan/constant/api_routes.dart';


class NetWorkHandler{


  static final client = http.Client();

    static final storage=FlutterSecureStorage();
    Map<String, String> headers = {"content-type": "application/json"};


    static Future<http.Response> post(var body, String endpoint)async{
    var response=await client.post(buildUrl(endpoint),body: body,
    headers: {
      "Content-type":"application/json"
    }
    );

    return response;
   }

  static Future<http.Response> postFormData(Map body, String endpoint)async{
    var response=await client.post(buildUrl(endpoint),body:body,
        headers:  {
          'contentType': 'multipart/form-data',

        }
    );
    return response;
  }

  setHeaderToken() async{
    var token= await NetWorkHandler.getToken();
      headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

   Future<http.Response> patch(var body, String endpoint)async{
     await setHeaderToken();
     var response=await client.patch(buildUrl(endpoint),body:body,
        headers:  headers
    );
    return response;
  }

  Future<http.Response> get(String endpoint)async{
    await setHeaderToken();
    var response=await client.get(buildUrl(endpoint),
        headers:  headers
    );
    return response;
  }

  Future<http.Response> delete(String endpoint)async{
    await setHeaderToken();
    var response=await client.delete(buildUrl(endpoint),
        headers:  headers
    );
    return response;
  }


  Future<String?> uploadImage(filename, url) async {
    var request= http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('Picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  static Uri buildUrl(String endpoint){
      final apiPath=ApiRoutes.apiHost+endpoint;
       return Uri.parse(apiPath);
    }

   static void storeToken(String token)async{
      await storage.write(key: "token", value: token);

   }

  static Future<String?> getToken()async{
      return await storage.read(key: "token");

    }



}