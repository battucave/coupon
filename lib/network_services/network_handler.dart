


import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logan/constant/api_routes.dart';


class NetWorkHandler{


  static final client = http.Client();
    static final storage=FlutterSecureStorage();

    static Future<http.Response> post(var body, String endpoint)async{
    var response=await client.post(buildUrl(endpoint),body: body,
    headers: {
      "Content-type":"application/json"
    }
    );
    print(response.body);
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