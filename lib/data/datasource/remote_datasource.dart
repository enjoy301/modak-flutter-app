import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/data/model/letter.dart';
import 'package:modak_flutter_app/data/model/chat.dart';
import 'package:modak_flutter_app/data/model/todo.dart';
import 'package:modak_flutter_app/data/model/user.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:modak_flutter_app/constant/strings.dart';

/// result: indicates whether communication was successful or not [ True | False ]
/// response: returns response [ Response Object | Error Object ]
/// message: returns when Dio error happened [ String ]

typedef RequestFunction = Future<Response<dynamic>> Function();

class RemoteDataSource {
  static final storage = FlutterSecureStorage();
  /**
   *
   * 유저 관련 함수들
   *
   */

  /// 회원가입을 요청하는 함수
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

  /// 토큰 로그인을 시도하는 함수
  Future<Map<String, dynamic>> tokenLogin() async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
        Strings.headerHost: "www.never.com",
        Strings.headerRefreshToken:
            await storage.read(key: Strings.refreshToken),
      })).get(
          "${dotenv.get(Strings.apiEndPoint)}/api/member/${await storage.read(key: Strings.memberId)}/login/token");
    },
        isUpdatingAccessToken: true,
        isUpdatingRefreshToken: true,
        isUpdatingMemberId: true,
        isUpdatingFamilyId: true);
  }

  /// 소셜 로그인을 시도하는 함수
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

  /// 카카오 로그인을 시도하는 함수
  Future<bool> kakaoLogin() async {
    try {
      if (await kakao.isKakaoTalkInstalled()) {
        await kakao.UserApi.instance.loginWithKakaoTalk();
      } else {
        await kakao.UserApi.instance.loginWithKakaoAccount();
      }
      kakao.User user = await kakao.UserApi.instance.me();
      storage.write(key: Strings.providerName, value: "KAKAO");
      storage.write(key: Strings.providerId, value: user.id.toString());
    } catch (e) {
      return false;
    }
    return true;
  }

  /// 나에 대한 정보를 요청하는 함수
  Future<Map<String, dynamic>> getMeInfo(String accessToken, int userId) async {
    return _tryRequest(() async {
      return await Dio(BaseOptions(headers: {
        Strings.headerAccessToken: accessToken,
      })).get(
          "${dotenv.get(Strings.apiEndPoint)}/api/member/${userId.toString()}");
    });
  }

  /// 유저 정보를 업데이트 하는 함수
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

  /// 나의 태그 정보를 업데이트 하는 함수
  Future<Map<String, dynamic>> updateMeTag(List<String> timeTags) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/member/${await storage.read(key: Strings.memberId)}/tag",
          data: {
            "tags": timeTags,
          });
    });
  }

  /// 가족 아이디를 변경하는 함수
  Future<Map<String, dynamic>> updateFamilyId(String familyCode) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.put(
        "${dotenv.get(Strings.apiEndPoint)}/api/member/${await storage.read(key: Strings.memberId)}/invitation",
        data: {
          Strings.invitationCode: familyCode,
        },
      );
    }, isUpdatingFamilyId: true);
  }
  /**
   *
   * 홈 정보 관련 함수들
   *
   */

  /// 홈 정보를 요청하는 함수
  Future<Map<String, dynamic>> getHomeInfo() {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.get(
          "${dotenv.get(Strings.apiEndPoint)}/api/home/${await storage.read(key: Strings.memberId)}?${Strings.date}=${DateFormat("yyyy-MM-dd").format(DateTime.now())}");
    });
  }

  /// 오늘의 한 마디를 조회하는 함수
  Future<Map<String, dynamic>> getTodayTalk(String fromDate, String toDate) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.get(
          "${dotenv.get(Strings.apiEndPoint)}/api/today-talk/${await storage.read(key: Strings.memberId)}?${Strings.fromDate}=$fromDate&${Strings.toDate}=$toDate");
    });
  }

  /// 오늘의 한 마디를 등록하는 함수
  Future<Map<String, dynamic>> postTodayTalk(String content) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.post(
          "${dotenv.get(Strings.apiEndPoint)}/api/today-talk/${await storage.read(key: Strings.memberId)}",
          data: {
            Strings.content: content,
            Strings.date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          });
    });
  }

  /// 오늘의 한 마디를 수정하는 함수
  Future<Map<String, dynamic>> updateTodayTalk(String content) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/today-talk/${await storage.read(key: Strings.memberId)}",
          data: {
            Strings.content: content,
            Strings.date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          });
    });
  }

  /// 오늘의 한 마디를 삭제하는 함수
  Future<Map<String, dynamic>> deleteTodayTalk() {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.delete(
          "${dotenv.get(Strings.apiEndPoint)}/api/today-talk/${await storage.read(key: Strings.memberId)}?${Strings.date}=${DateFormat("yyyy-MM-dd").format(DateTime.now())}");
    });
  }

  /// 오늘의 운세를 가져오는 함수
  Future<Map<String, dynamic>> getTodayFortune() {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.get(
          "${dotenv.get(Strings.apiEndPoint)}/api/today-fortune/${await storage.read(key: Strings.memberId)}");
    });
  }
  /**
   *
   * 할 일 관련 함수들
   *
   */

  /// 할 일 정보를 요청하는 함수
  Future<Map<String, dynamic>> getTodos(String fromDate, String toDate) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.get(
        "${dotenv.get(Strings.apiEndPoint)}/api/todo/from-to-date?${Strings.fromDate}=$fromDate&${Strings.toDate}=$toDate",
      );
    });
  }

  /// 할 일을 등록하는 함수
  Future<Map<String, dynamic>> postTodo(
      Todo todo, String fromDate, String toDate) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.post("${dotenv.get(Strings.apiEndPoint)}/api/todo", data: {
        Strings.memberId: await storage.read(key: Strings.memberId),
        Strings.title: todo.title,
        Strings.timeTag: todo.timeTag,
        Strings.repeat: todo.repeat,
        Strings.memo: todo.memo,
        Strings.date: todo.date,
        Strings.fromDate: fromDate,
        Strings.toDate: toDate,
      });
    });
  }

  /// 할 일을 업데이트 하는 함수
  Future<Map<String, dynamic>> updateTodo(
      Todo todo, int isAfterUpdate, String fromDate, String toDate) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/todo/${todo.todoId}",
          data: {
            Strings.memberId: await storage.read(key: Strings.memberId),
            Strings.title: todo.title,
            Strings.timeTag: todo.timeTag,
            Strings.repeat: todo.repeat,
            Strings.memo: todo.memo,
            Strings.date: todo.date,
            Strings.fromDate: fromDate,
            Strings.toDate: toDate,
            Strings.isAfterUpdate: isAfterUpdate,
          });
    });
  }

  /// 할 일을 완료 함수
  Future<Map<String, dynamic>> doneTodo(
      Todo todo, int isDone, String fromDate, String toDate) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/todo/done/${todo.todoId}",
          data: {
            Strings.date: todo.date,
            Strings.fromDate: fromDate,
            Strings.toDate: toDate,
            Strings.isDone: isDone,
          });
    });
  }

  /// 할 일을 제거하는 함수
  Future<Map<String, dynamic>> deleteTodo(
      Todo todo, int isAfterUpdate, String fromDate, String toDate) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.delete(
          "${dotenv.get(Strings.apiEndPoint)}/api/todo/${todo.todoId}",
          data: {
            Strings.date: todo.date,
            Strings.fromDate: fromDate,
            Strings.toDate: toDate,
            Strings.isAfterDelete: isAfterUpdate,
          });
    });
  }

  /**
   *
   * 채팅 함수
   *
   */

  /// 편지들을 조회하는 함수
  Future<Map<String, dynamic>> getLetters() {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.get(
            "${dotenv.get(Strings.apiEndPoint)}/api/letter/${await storage.read(key: Strings.memberId)}");
      },
    );
  }

  /// 편지를 발송하는 함수
  Future<Map<String, dynamic>> sendLetter(Letter letter) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.post(
          "${dotenv.get(Strings.apiEndPoint)}/api/letter/${await storage.read(key: Strings.memberId)}",
          data: {
            Strings.content: letter.content,
            Strings.date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
            Strings.toMemberId: letter.toMemberId,
            Strings.envelope: letter.envelope.toString(),
          });
    });
  }

  // 채팅 목록 불러오는 함수
  Future<Map<String, dynamic>> getChats(int count, int lastId) {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.get(
        "${dotenv.get(Strings.apiEndPoint)}/api/message/chat?count=$count&lastId=$lastId",
      );
    });
  }

  // 커넥션 목록 불러오는 함수
  Future<Map<String, dynamic>> getConnections() {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth
          .get("${dotenv.get(Strings.apiEndPoint)}/api/message/connection");
    });
  }

  // 채팅 보내는 함수
  Future<Map<String, dynamic>> postChat(String chat) {
    return _tryRequest(() async {
      log("${await storage.read(key: Strings.memberId)}");
      log("${await storage.read(key: Strings.familyId)}");
      final Dio dio = Dio();
      return dio.post(
        "https://api.modak-talk.com/message",
        data: {
          "user_id": int.parse((await storage.read(key: Strings.memberId))!),
          "family_id": int.parse((await storage.read(key: Strings.familyId))!),
          "content": chat,
          "metadata": {"type_code": "plain"},
        },
      );
    });
  }

  /**
   *
   * 보조 함수들
   *
   */

  /// accessToken, refresh Token 검증하는 과정이 포함된 Dio
  /// accessToken 을 포함할 시에 아래 Dio 를 통해 요청
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
          final clonedRequest = await Dio().request(error.requestOptions.path,
              options: Options(method: error.requestOptions.method, headers: {
                Strings.headerAccessToken:
                    await storage.read(key: Strings.accessToken),
              }),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);
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

  /// api 함수 exception 처리를 도와주는 함수
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
        print(response.data);
        await storage.write(
            key: Strings.memberId,
            value: response.data['data']['memberResult'][Strings.memberId]
                .toString());
      }
      if (isUpdatingFamilyId) {
        await storage.write(
            key: Strings.familyId,
            value: response.data['data'][Strings.memberResult][Strings.familyId]
                .toString());
      }
    } catch (e) {
      if (e is DioError) {
        log("e: $e");
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

  /// accessToken 재발급을 요청하는 함수
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
}
