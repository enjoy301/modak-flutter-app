import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/ui/auth/auth_landing_screen.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';

/// 회원가입 완료 실행 함수
Future<Map<String, dynamic>> signUp() async {
  /// 회원가입을 위한 정보들이 준비되었는지 확인
  if (PrefsUtil.getString("auth_name") == null ||
      PrefsUtil.getString("auth_birth_day") == null ||
      PrefsUtil.getString("auth_role") == null ||
      // PrefsUtil.getString("fcmToken") == null ||
      PrefsUtil.getString("provider") == null ||
      PrefsUtil.getInt("provider_id") == null) {
    return {"result": "NULL"};
  }
  try {
    Response response =
        await Dio().post("${dotenv.get("API_ENDPOINT")}/api/member/new", data: {
      "name": PrefsUtil.getString("auth_name")!,
      "birthday": PrefsUtil.getString("auth_birth_day"),
      "isLunar": PrefsUtil.getBool("auth_is_Lunar") ?? false ? 1 : 0,
      "role": PrefsUtil.getString("auth_role")!.split(".").last.toUpperCase(),
      "fcmToken": "qgti2uitu03gqrue9jqgn2342vwlngwkfw",
      "provider": PrefsUtil.getString("provider"),
      "providerId": (PrefsUtil.getInt("provider_id")!).toString(),
      "familyId": -1,
    });
    print("회원가입 성공");

    /// 회원가입 성공시 accessToken 과 refreshToken 을 local storage 에 저장
    PrefsUtil.setString("access_token", response.headers['access_token']![0]);
    PrefsUtil.setString("refresh_token", response.headers['refresh_token']![0]);

    /// 아이디 정보들 저장
    PrefsUtil.setInt("user_id", response.data['data']['memberId']);
    PrefsUtil.setInt("family_id", response.data['data']['familyId']);
    PrefsUtil.setInt("anniversary_id", response.data['data']['anniversaryId']);

    return {"response": response, "result": "SUCCESS"};
  } catch (e) {
    if (e is DioError) {
      print(await e.response!.data);
    }
    print("회원가입 실패");
    return {"result": "FAIL"};
  }
}

/// 소셜 로그인 확인 함수
Future<Map<String, dynamic>> socialLogin(BuildContext context) async {
  print(PrefsUtil.getString("provider"));
  print(PrefsUtil.getInt("provider_id"));

  try {
    Response response = await Dio()
        .post("${dotenv.get("API_ENDPOINT")}/api/member/social-login", data: {
      "provider": "${PrefsUtil.getString("provider")}",
      "providerId": (PrefsUtil.getInt("provider_id")!).toString(),
    });
    PrefsUtil.setString("access_token", response.headers['access_token']![0]);
    PrefsUtil.setString("refresh_token", response.headers['refresh_token']![0]);

    Map<String, dynamic> userInfo = response.data['data']['result'];
    print(userInfo);

    String name = userInfo['name'];
    int isLunar = userInfo['isLunar'];
    DateTime birthDay = DateTime.parse(userInfo['birthDay'] as String);
    String? profileImageUrl = userInfo['profileImageUrl'];
    FamilyType? familyType = userInfo['role'].toString().toFamilyType();
    Color color = userInfo['color'].toString().toColor() ?? Colors.black;

    print("name: ${name.toString()}");
    print("isLunar: ${isLunar.toString()}");
    print("birthDay: ${birthDay.toString()}");
    print("profileImageUrl: ${profileImageUrl.toString()}");
    print("familyType: ${familyType.toString()}");
    print("color: ${color.toString()}");
    print(response.data);

    PrefsUtil.setInt("user_id", userInfo['id']);
    return {
      "result": "SUCCESS",
      "response": response,
    };
  } catch (e) {
    if (e is DioError) {
      print(await e.response!.data);
      return {"result": "FAIL", "code": e.response!.data['code']};
    }
  }
  return {"result": "FAIL", "code": "unknownError"};
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
      return {"result": "FAIL", "code": e.response!.data['code']};
    }
    print("로그인 실패");
    return {"result": "FAIL"};
  }
}

/// access Token 재발급 함수
Future<Map<String, dynamic>> requestAccessToken(BuildContext context) async {
  try {
    Response response = await Dio()
        .post("${dotenv.get("API_ENDPOINT")}/api/token/reissue", data: {
      "accessToken": PrefsUtil.getString("access_token"),
      "refreshToken": PrefsUtil.getString("refresh_token"),
    });
    PrefsUtil.setString("access_token", response.headers['access_token']![0]);
    return {"result": "SUCCESS"};
  } catch (e) {
    if (e is DioError) {
      if (e.message == "ExpiredRefreshTokenException") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AuthLandingScreen()),
            ModalRoute.withName(
                '/') // Replace this with your root screen's route name (usually '/')
            );
      }
      return {"result": "FAIL", "message": e.message};
    }
    return {"result": "FAIL", "message": "UNEXPECTED"};
  }
}
