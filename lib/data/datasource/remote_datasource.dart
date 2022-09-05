import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/data/model/user.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:modak_flutter_app/constant/strings.dart';

/// result: indicates whether communication was successful or not [ True | False ]
/// response: returns response [ Response Object | Error Object ]
/// message: returns when Dio error happened [ String ]

typedef RequestFunction = Future<Response<dynamic>> Function();

class RemoteDataSource {
  static final storage = FlutterSecureStorage();

  /// accessToken, refresh Token 검증하는 과정이 포함된 Dio
  Future<Dio> authDio() async {
    final Dio dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String? accessToken = await storage.read(key: Strings.accessToken);
      options.headers[Strings.headerAccessToken] = accessToken;
      return handler.next(options);
    }, onError: (error, handler) async {
      if (error.response?.data['code'] == "ExpiredAccessTokenException") {
        Map<String, dynamic> response = await _reIssueAccessToken();
        if (response[Strings.result]) {
          await storage.write(
              key: Strings.accessToken,
              value: response[Strings.response]
                  .headers[Strings.headerAccessToken]![0]);
          final clonedRequest = await Dio().request(error.requestOptions.path, options: Options(
              method: error.requestOptions.method,
              headers: {
                Strings.headerAccessToken: await storage.read(key: Strings.accessToken),
              }),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters
          );
          return handler.resolve(clonedRequest);
        }
        if (response[Strings.message] == "ExpiredRefreshTokenException") {
          storage.deleteAll();
          Get.offAllNamed("/auth/landing");
        }
      }
      return handler.next(error);
    }));

    return dio;
  }

  /// user request
  Future<Map<String, dynamic>> signUp(String name, String birthDay, int isLunar,
      String role, String fcmToken, int familyId) async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
        Strings.headerHost: "www.never.com",
      })).post("${dotenv.get(Strings.apiEndPoint)}/api/member", data: {
        Strings.providerName: await storage.read(key: Strings.providerName),
        Strings.providerId: await storage.read(key: Strings.providerId),
        Strings.name: name,
        Strings.birthDay: birthDay,
        Strings.isLunar: isLunar,
        Strings.role: role,
        Strings.fcmToken: "fcmToken",
        Strings.familyId: -1,
      });
    });
  }

  Future<Map<String, dynamic>> getMeInfo(String accessToken, int userId) async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
        Strings.headerAccessToken: accessToken,
      })).get(
          "${dotenv.get(Strings.apiEndPoint)}/api/member/${userId.toString()}");
    });
  }

  Future<Map<String, dynamic>> _reIssueAccessToken() async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
        Strings.headerHost: "www.never.com",
        Strings.headerAccessToken: await storage.read(key: Strings.accessToken),
        Strings.headerRefreshToken:
            await storage.read(key: Strings.refreshToken),
      })).get("${dotenv.get(Strings.apiEndPoint)}/api/token/reissue");
    });
  }

  /// login
  Future<Map<String, dynamic>> tokenLogin() async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
        Strings.headerHost: "www.never.com",
        Strings.headerRefreshToken:
            await storage.read(key: Strings.refreshToken),
      })).get(
          "${dotenv.get(Strings.apiEndPoint)}/api/member/${await storage.read(key: Strings.memberId)}/login/token");
    }, isUpdatingAccessToken: true, isUpdatingRefreshToken: true);
  }

  Future<Map<String, dynamic>> socialLogin() async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
        Strings.headerProviderName:
            await storage.read(key: Strings.providerName),
        Strings.headerProviderId: await storage.read(key: Strings.providerId),
      })).get("${dotenv.get(Strings.apiEndPoint)}/api/member/login/social");
    },
        isUpdatingAccessToken: true,
        isUpdatingRefreshToken: true,
        isUpdatingMemberId: true,
        isUpdatingFamilyId: true);
  }

  Future<bool> kakaoLogin() async {
    try {
      late kakao.OAuthToken token;
      if (await kakao.isKakaoTalkInstalled()) {
        token = await kakao.UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await kakao.UserApi.instance.loginWithKakaoAccount();
      }
      kakao.User user = await kakao.UserApi.instance.me();
      storage.write(key: Strings.providerName, value: "KAKAO");
      storage.write(key: Strings.providerId, value: user.id.toString());
    } catch (e) {
      return false;
    }
    return true;
  }

  /// me
  Future<Map<String, dynamic>> updateMeInfo(User user) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/member/${await storage.read(key: Strings.memberId)}",
          data: {
            Strings.name: user.name,
            Strings.birthDay: user.birthDay,
            Strings.isLunar: user.isLunar ? 1 : 0,
            Strings.role: user.role,
            Strings.color: user.color,
          });
    });
  }

  /// todo
  Future<Map<String, dynamic>> getTodos(String fromDate, String toDate) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.post("${dotenv.get(Strings.apiEndPoint)}/api/todo/from-to-date", data: {
        Strings.fromDate: fromDate,
        Strings.toDate: toDate,
      });
    });
  }


  Future<Map<String, dynamic>> _tryRequest(
    RequestFunction function, {
    bool isUpdatingAccessToken = false,
    bool isUpdatingRefreshToken = false,
    bool isUpdatingMemberId = false,
    bool isUpdatingFamilyId = false,
  }) async {
    Response? response;
    try {
      response = await function.call();
      if (isUpdatingAccessToken) {
        await storage.write(
            key: Strings.accessToken,
            value: response.headers[Strings.headerAccessToken]![0]);
      }
      if (isUpdatingRefreshToken) {
        await storage.write(
            key: Strings.refreshToken,
            value: response.headers[Strings.headerRefreshToken]![0]);
      }
      if (isUpdatingMemberId) {
        await storage.write(
            key: Strings.memberId,
            value: response.data['data']['memberResult'][Strings.memberId]
                .toString());
      }
      if (isUpdatingFamilyId) {
        await storage.write(
            key: Strings.familyId,
            value:
                response.data['data']['result'][Strings.familyId].toString());
      }
    } catch (e) {
      if (e is DioError) {
        return {
          Strings.result: false,
          Strings.response: e,
          Strings.message: e.response?.data['code'] ?? "no message",
        };
      }
    }
    return {
      Strings.result: true,
      Strings.response: response,
    };
  }
}
