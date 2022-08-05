import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';

/// 회원가입 완료 실행 함수
Future<Map<String, dynamic>> signUp() async {
  /// 회원가입을 위한 정보들이 준비되었는지 확인
  if (PrefsUtil.getString("user_name") == null ||
      PrefsUtil.getString("user_birth_day") == null ||
      PrefsUtil.getString("user_role") == null ||
      // PrefsUtil.getString("fcmToken") == null ||
      PrefsUtil.getString("provider") == null ||
      PrefsUtil.getInt("provider_id") == null) {
    return {"result": "NULL"};
  }
  try {
    Response response =
        await Dio().post("${dotenv.get("API_ENDPOINT")}/api/member/new", data: {
      "name": PrefsUtil.getString("user_name")!,
      "birthday": PrefsUtil.getString("user_birth_day"),
      "isLunar": PrefsUtil.getBool("user_is_Lunar") ?? false ? 1 : 0,
      "role": PrefsUtil.getString("user_role")!.split(".").last.toUpperCase(),
      "fcmToken": "qgti2uitu03gqrue9jqgn2342vwlngwkfw",
      "provider": PrefsUtil.getString("provider"),
      "providerId": PrefsUtil.getInt("provider_id").toString()
    });
    print("회원가입 성공");

    /// 회원가입 성공시 accessToken 과 refreshToken 을 local storage 에 저장
    PrefsUtil.setString("access_token", response.headers['access_token']![0]);
    PrefsUtil.setString("refresh_token", response.headers['refresh_token']![0]);

    return {"response": response, "result": "SUCCESS"};
  } catch (e) {
    print("회원가입 실패");
    return {"result": "FAIL"};
  }
}

/// 소셜 로그인 확인 함수
Future<Map<String, dynamic>> socialLogin() async {
  print(PrefsUtil.getString("provider"));
  print(PrefsUtil.getInt("provider_id"));

  try {
    Response response = await Dio()
        .post("${dotenv.get("API_ENDPOINT")}/api/member/social-login", data: {
      "provider": "${PrefsUtil.getString("provider")}",
      "providerId": "${PrefsUtil.getInt("provider_id").toString()}",
    });
    PrefsUtil.setString("access_token", response.headers['access_token']![0]);
    PrefsUtil.setString("refresh_token", response.headers['refresh_token']![0]);
    return {
      "result": "SUCCESS",
      "response": response,
    };
  } catch (e) {
    if (e is DioError) {

      return {
        "result": "FAIL",
        "code": e.response!.data['code']
      };
    }
  }
  return {
    "result": "FAIL",
    "code": "unknownError"
  };
}

/// 로그인 시도 함수
Future<Map<String, dynamic>> tokenLogin() async {

  try {
    Response response = await Dio()
        .post("${dotenv.get("API_ENDPOINT")}/api/member/token-login", data: {
      "accessToken": PrefsUtil.getString("access_token"),
      "refreshToken": PrefsUtil.getString("refresh_token"),
    });
    print("로그인 성공");

    /// 로그인 성공시 accessToken 과 refreshToken 을 local storage 에 업데이트
    PrefsUtil.setString("access_token", response.headers['access_token']![0]);
    PrefsUtil.setString("refresh_token", response.headers['refresh_token']![0]);

    return {"response": response, "result": "SUCCESS"};
  } catch (e) {
    if (e is DioError) {
      return {
        "result": "FAIL",
        "code": e.response!.data['code']
      };
    }
    print(e);
    print("로그인 실패");
    return {"result": "FAIL"};
  }
}
