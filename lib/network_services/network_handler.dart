


import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logan/constant/api_routes.dart';


class NetWorkHandler{


  static final client = http.Client();

   static FlutterSecureStorage storage = FlutterSecureStorage();
    Map<String, String> headers = {"content-type": "application/json"};
   Map<String, String> multipardHeaders = { "Accesstoken": "access_token"};


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

  Future<http.Response> getWithParameters(String endpoint,int param,bool paramIsAtEnd)async{
    await setHeaderToken();
    var response=await client.get(buildUrlWithParameters(endpoint,param,paramIsAtEnd),
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


  Future<http.StreamedResponse>patchMultipartRequest(String filepath, url,String endpoint) async {

    var token=await getToken();
    var request= http.MultipartRequest('PATCH', buildUrl(endpoint),);
    request.headers["content-type"]="multipart/form-data";
    request.headers["authorization"]="Bearer ${token!}";
   print(request.headers);
    request.files.add(http.MultipartFile('file',
        File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
        filename: filepath.split("/").last),

    );
    var res = await request.send();
    print(res.toString());
    return res;
  }

  static Uri buildUrl(String endpoint){
      final apiPath=ApiRoutes.apiHost+endpoint;
       return Uri.parse(apiPath);
    }

  static Uri buildUrlWithParameters(String endpoint,  int param,bool paramIsAtEnd){

    final apiPath= !paramIsAtEnd?
             ApiRoutes.apiHost+"api/v1/${param}/"+endpoint:
             ApiRoutes.apiHost+"${endpoint}"+param.toString();

    print("TRUE PATH");
    print(Uri.parse(apiPath));
    return Uri.parse(apiPath);
  }

   static void storeToken(String token)async{
      await storage.write(key: "token", value: token);

   }

  static Future<String?> getToken()async{
      return await storage.read(key: "token");

    }



}