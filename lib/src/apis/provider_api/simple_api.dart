import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_app/src/models-new/api_list_model.dart';
import 'package:flutter_app/src/models-new/api_model.dart';
import 'package:flutter_app/src/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class SimpleAPI {
  static final String baseUrl = BASE_URL;
  static final String version = VERSION;

  static Future<List<T>> getAll<T>(Function(Map<String , dynamic>) fromMap,String endtitypoint, Map<String, dynamic> queryParameter) async {
    String uri = "https://beautyathome2.azurewebsites.net/api/v1.0/$endtitypoint";
    http.Response response = await http.get(uri);
    List<T> list = new List();
    dynamic jsonRaw = json.decode(response.body);
    print(response.body);
    List<dynamic> content = jsonRaw['content'];
    if (content.length > 0) {
      content.forEach((element) {
        list.add(fromMap(element));
      });
    }
    return list;
  }
  static Future<List<T>> getAllNew<T>(Function(Map<String , dynamic>) fromMap, String uri) async {
    http.Response response = await http.get(uri);
    List<T> list = new List();
    dynamic jsonRaw = json.decode(response.body);
    print(response.body);
    List<dynamic> content = jsonRaw['content'];
    if (content.length > 0) {
      content.forEach((element) {
        list.add(fromMap(element));
      });
    }
    return list;
  }

  static Future<dynamic> getById(String entityEndpoint, String id, {
    Map<String, String> headers, Function(dynamic) fromJson,
  }) async {
    var uri = 'https://beautyathome2.azurewebsites.net/api/v1.0/$entityEndpoint/$id';
    var encoded = Uri.encodeFull(uri);

    http.Response response = await http.get(encoded, headers: headers,);

    log(response.body);
    if (response.statusCode == 200) {
      return fromJson(response.body);
    }
  }

  static Future<ServiceModel> postFile<ServiceModel>(
      String entityEndpoint, {
        dynamic body,
        Map<String, String> headers,
        String description,
        String serviceName,
        String price,
        String estimateTime,
        String accountId,
        String serviceTypeId,
        String summary,
        String path,
      }) async {
    final uri = Uri.parse(baseUrl + "/$entityEndpoint");
    var request = new http.MultipartRequest("POST", uri)..
    fields['Description'] = description..
    fields['ServiceName'] = serviceName..
    fields['Price'] = price..
    fields['EstimateTime'] = estimateTime..
    fields['AccountId'] = accountId..
    fields['ServiceTypeId'] = serviceTypeId..
    fields['Summary'] = summary..
    files.add(await http.MultipartFile.fromPath("file", path, contentType: MediaType('application', 'x-tar')));

    request.send().then((value) => {
      if (value.statusCode == 201)
        {
          print('Insert success'),
        }
      else
        {
          print('Insert failed: ' + value.statusCode.toString()),
        }
    });
    return null;
  }

  // static Future<ApiModel<T>> postWithFile<T>(
  //     String entityEndpoint, {
  //       dynamic body,
  //       Map<String, String> headers,
  //       List<String> filePaths
  //     }) async {,,
  //   Uri uri = Uri.https(
  //     baseUrl,
  //     entityEndpoint,
  //   );
  //   http.MultipartRequest request = new http.MultipartRequest("POST", uri);
  //
  //   filePaths.forEach((element) => );
  //   http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
  //       'file', filePaths);
  //
  //   request.files.add(multipartFile);
  //
  //   http.Response response = await request.send();
  // }

  static Future<bool> put(String entityEndpoint, String id, {Map<String, String> headers, dynamic body,}) async {
    final uri = Uri.parse(baseUrl + "$entityEndpoint/$id");
    print("url nè : " + uri.toString());
    print("body nè: " + body);
    http.Response response = await http.put(uri, headers: headers, body: body);
    print("lỗi nè: " + response.statusCode.toString());
    if (response.statusCode == 204) {
      print("status 204");
      return true;
    }
  }

  static Future<ApiModel<T>> post<T>(String entityEndpoint, {
    dynamic body,
    Map<String, String> headers,
  }) async {
    Uri uri = Uri.https(
      baseUrl,
      entityEndpoint,
    );
    http.Response response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 201) {
      return ApiModel<T>.fromJson(jsonDecode(response.body));
    }
  }

  // static Future<bool> put(String entityEndpoint, String id, {
  //       Map<String, String> headers,
  //       dynamic body,
  //     }) async {
  //   Uri uri = Uri.https(
  //     baseUrl,
  //     entityEndpoint + "/$id",
  //   );
  //   http.Response response = await http.put(uri, headers: headers, body: body);
  //   if (response.statusCode == 204) {
  //     return true;
  //   }
  // }

  static Future<bool> delete(String entityEndpoint, String id,
      {Map<String, String> headers, dynamic body}) async {
    Uri uri = Uri.https(
      baseUrl,
      entityEndpoint + "/$id",
    );
    http.Response response = await http.put(uri, headers: headers, body: body);
    if (response.statusCode == 204) {
      return true;
    }
  }
}
