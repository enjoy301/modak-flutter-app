import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:provider/provider.dart';

Future<Map<String, dynamic>> reloadUserInfo(BuildContext context) async {
  if (PrefsUtil.getInt("user_id") == null) {
    print("!");
    return {"result": "FAIL", "message": "NOUSERID"};
  }
  if (PrefsUtil.getString("access_token") == null) {
    print("!!");
    return {"result": "FAIL", "message": "NOTOKEN"};
  }
  try {
    Response response = await Dio().post(
        "${dotenv.get("API_ENDPOINT")}/api/info/member/${PrefsUtil.getInt("user_id")}",
        data: {
          "accessToken": PrefsUtil.getString("access_token"),
        });
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

    // ignore: use_build_context_synchronously
    context.read<UserProvider>().setUserInfo(
        name, isLunar, birthDay, profileImageUrl, familyType, color);
    return {"result": "SUCCESS", "response": response};
  } catch (e) {
    if (e is DioError) {
      print(e.response!.data);
    }
    print(e);
    return {};
  }

  return {};
}
