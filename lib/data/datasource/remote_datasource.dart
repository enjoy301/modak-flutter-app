import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/route_manager.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/ui/auth/auth_landing_screen.dart';

/// result: indicates whether communication was successful or not [ True | False ]
/// response: returns response [ Response Object | Error Object ]
/// message: returns when Dio error happened [ String ]

typedef RequestFunction = Future<Response<dynamic>> Function();

class RemoteDataSource {
  static final storage = FlutterSecureStorage();

  final _tokenDio = Dio().interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {},
      onError: (error, handler) async {
        if (error.response?.statusMessage == "ExpiredAccessTokenException") {
          String? accessToken = await storage.read(key: Strings.accessToken);
          String? refreshToken = await storage.read(key: Strings.refreshToken);
          if (accessToken == null || refreshToken == null) {
            storage.deleteAll();
            Get.offAll(AuthLandingScreen());
            return;
          }
          try {
            Response response = await Dio(BaseOptions(headers: {
              Strings.headerHost: "www.never.com",
              Strings.headerAccessToken: accessToken,
              Strings.headerRefreshToken: refreshToken,
            })).get("${dotenv.get(Strings.apiEndPoint)}/api/token/reissue");
          } catch (e) {}
        }
      }));

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

  Future<Map<String, dynamic>> getUserInfo(
      String accessToken, int userId) async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
        Strings.headerAccessToken: accessToken,
      })).get(
          "${dotenv.get(Strings.apiEndPoint)}/api/member/${userId.toString()}");
    });
  }

  Future<Map<String, dynamic>> _reIssueAccessToken(
      String accessToken, String refreshToken) async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
        Strings.headerHost: "www.never.com",
        Strings.headerAccessToken: accessToken,
        Strings.headerRefreshToken: refreshToken,
      })).get("${dotenv.get(Strings.apiEndPoint)}/api/token/reissue");
    });
  }

  /// login
  Future<Map<String, dynamic>> tokenLogin() async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
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
      late OAuthToken token;
      if (await isKakaoTalkInstalled()) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }
      User user = await UserApi.instance.me();
      storage.write(key: Strings.providerName, value: "KAKAO");
      storage.write(key: Strings.providerId, value: user.id.toString());
    } catch (e) {
      return false;
    }
    return true;
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
            value:
                response.data['data']['result'][Strings.memberId].toString());
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
