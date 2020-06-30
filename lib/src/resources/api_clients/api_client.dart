import 'package:chopper/chopper.dart';
import 'package:j3enterprise/src/resources/api_clients/mobile_data_interceptor.dart';
import 'package:j3enterprise/src/resources/services/rest_api_service.dart';
import 'package:j3enterprise/src/resources/shared/preferences/user_share_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String apiConnection = 'API';

  static const String URL = 'http://app.j3enterprisecloud.com';

  static ChopperClient chopper;

  static void updateClient(String baseUrl) {
    chopper = ChopperClient(
        baseUrl: baseUrl,
        services: [
          // inject the generated service
          RestApiService.create()
        ],
        interceptors: [
          MobileDataInterceptor(),
          HeadersInterceptor({
            'content-type': 'application/json',
            'Accept': 'application/json'
          }),
          HttpLoggingInterceptor(),
          (Response response) async {
            if (response.statusCode == 401) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove("access_token");
              await prefs.remove("Abp.TenantId");
            }
            return response;
          },
          (Request request) async {
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> d905bf68ae66d893fb1f9bea2fec24a0c63aaa81
            Map<String, String> mapUserSharedData = Map();
            UserSharedData userSharedData = new UserSharedData();
            mapUserSharedData = await userSharedData.getUserSharedPref();
            String _tenantId = mapUserSharedData['tenantId'];
<<<<<<< HEAD
=======
=======
            Map<String, String> mapuserSharedData = Map();
            UserSharedData userSharedData = new UserSharedData();
            mapuserSharedData = await userSharedData.getUserSharedPref();
            String _tenantId = mapuserSharedData['tenantId'];
>>>>>>> 3155339cff24631565403ae694c6e3af0e8966bb
>>>>>>> d905bf68ae66d893fb1f9bea2fec24a0c63aaa81

            SharedPreferences prefs = await SharedPreferences.getInstance();
            String token = await prefs.get("access_token");
            String tenantId = _tenantId;

            Map<String, String> map = {
              "Authorization": "Bearer $token",
              'Abp.TenantId': '$tenantId'
            };

            request.headers.addAll(map);
            return request;
          },
        ],
        converter: JsonConverter());
  }
}
