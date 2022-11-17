import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/chat/chat_paging_DTO.dart';
import 'package:modak_flutter_app/data/dto/letter.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// result: indicates whether communication was successful or not [ True | False ]
/// response: returns response [ Response Object | Error Object ]
/// message: returns when Dio error happened [ String ]

typedef RequestFunction = Future<Response<dynamic>> Function();

class RemoteDataSource {
  RemoteDataSource._privateConstructor();
  static final RemoteDataSource _instance =
      RemoteDataSource._privateConstructor();

  factory RemoteDataSource() {
    return _instance;
  }

  static final storage = FlutterSecureStorage();

  /**
   *
   * 유저 관련 함수들
   *
   */

  /// 회원가입을 요청하는 함수
  Future<Map<String, dynamic>> signUp(
    String name,
    String birthDay,
    int isLunar,
    String role,
    String fcmToken,
    int familyId,
  ) async {
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            headers: {
              Strings.headerHost: "www.never.com",
            },
          ),
        ).post(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/auth",
          data: {
            Strings.providerName: await storage.read(key: Strings.providerName),
            Strings.providerId: await storage.read(key: Strings.providerId),
            Strings.name: name,
            Strings.birthDay: birthDay,
            Strings.isLunar: isLunar,
            Strings.role: role,
            Strings.fcmToken: "fcmToken",
            Strings.familyId: -1,
          },
        );
      },
      isUpdatingAccessToken: true,
      isUpdatingRefreshToken: true,
      isUpdatingMemberId: true,
      isUpdatingFamilyId: true,
    );
  }

  /// 토큰 로그인을 시도하는 함수
  Future<Map<String, dynamic>> tokenLogin() async {
    log("tokenLogin");
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            headers: {
              Strings.headerHost: "www.never.com",
              Strings.headerRefreshToken:
                  await storage.read(key: Strings.refreshToken),
            },
          ),
        ).get(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/auth/login/token",
        );
      },
      isUpdatingAccessToken: true,
      isUpdatingRefreshToken: true,
      isUpdatingMemberId: true,
      isUpdatingFamilyId: true,
    );
  }

  /// 소셜 로그인을 시도하는 함수
  Future<Map<String, dynamic>> socialLogin() async {
    log("socialLogin");
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            headers: {
              Strings.headerProviderName:
                  await storage.read(key: Strings.providerName),
              Strings.headerProviderId:
                  await storage.read(key: Strings.providerId),
            },
          ),
        ).get(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/auth/login/social",
        );
      },
      isUpdatingAccessToken: true,
      isUpdatingRefreshToken: true,
      isUpdatingMemberId: true,
      isUpdatingFamilyId: true,
    );
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
      storage.write(
        key: Strings.providerName,
        value: "KAKAO",
      );
      storage.write(
        key: Strings.providerId,
        value: user.id.toString(),
      );
    } catch (e) {
      print("what$e");
      return false;
    }
    return true;
  }

  /// 애플 로그인을 시도하는 함수
  Future<Map> appleLogin() async {
    String name = "";
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.fullName,
          AppleIDAuthorizationScopes.email,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: "modak.wowbros.com",
          redirectUri: Uri.parse(
            "https://fluorescent-hip-reason.glitch.me/callbacks/sign_in_with_apple",
          ),
        ),
      );
      Map<String, dynamic> tokenParsed = Jwt.parseJwt(
        appleCredential.identityToken!,
      );

      if (appleCredential.givenName != null) {
        name = "${appleCredential.givenName} ${appleCredential.familyName}";
      }

      String userId = tokenParsed['sub'];
      storage.write(key: Strings.providerName, value: "APPLE");
      storage.write(key: Strings.providerId, value: userId);
    } catch (e) {
      return {
        Strings.result: false,
      };
    }
    return {
      Strings.result: true,
      Strings.name: name,
    };
  }

  /// 나에 대한 정보를 요청하는 함수
  Future<Map<String, dynamic>> getMeInfo(String accessToken, int userId) async {
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            headers: {
              Strings.headerAccessToken: accessToken,
            },
          ),
        ).get(
          "${dotenv.get(Strings.apiEndPoint)}/api/member/${userId.toString()}",
        );
      },
    );
  }

  /// 유저 정보를 업데이트 하는 함수
  Future<Map<String, dynamic>> updateMeInfo(User user) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/member",
          data: {
            Strings.name: user.name,
            Strings.birthDay: user.birthDay,
            Strings.isLunar: user.isLunar ? 1 : 0,
            Strings.role: user.role,
            Strings.color: user.color,
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> deleteMe() {
    return _tryRequest(() async {
      final Dio auth = await authDio();
      return auth.delete("${dotenv.get(Strings.apiEndPoint)}/api/v2/member");
    });
  }

  /// 나의 태그 정보를 업데이트 하는 함수
  Future<Map<String, dynamic>> updateMeTag(List<String> timeTags) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/member/tags",
          data: {
            "tags": timeTags,
          },
        );
      },
    );
  }

  /// 가족 아이디를 변경하는 함수
  Future<Map<String, dynamic>> updateFamilyId(String familyCode) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/member/invitations",
          data: {
            Strings.invitationCode: familyCode.trim(),
          },
        );
      },
      isUpdatingFamilyId: true,
    );
  }

  /**
   *
   * 홈 정보 관련 함수들
   *
   */

  /// 홈 정보를 요청하는 함수
  Future<Map<String, dynamic>> getHomeInfo() {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();

        return auth.get(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/home?${Strings.date}=${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
        );
      },
    );
  }

  /// 오늘의 한 마디를 조회하는 함수
  Future<Map<String, dynamic>> getTodayTalk(String fromDate, String toDate) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();

        return auth.get(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/today-talk?${Strings.fromDate}=$fromDate&${Strings.toDate}=$toDate",
        );
      },
    );
  }

  /// 오늘의 한 마디를 등록하는 함수
  Future<Map<String, dynamic>> postTodayTalk(String content) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.post(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/today-talk",
          data: {
            Strings.content: content,
            Strings.date: DateFormat("yyyy-MM-dd").format(
              DateTime.now(),
            ),
          },
        );
      },
    );
  }

  /// 오늘의 한 마디를 수정하는 함수
  Future<Map<String, dynamic>> updateTodayTalk(String content) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/today-talk",
          data: {
            Strings.content: content,
            Strings.date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          },
        );
      },
    );
  }

  /// 오늘의 한 마디를 삭제하는 함수
  Future<Map<String, dynamic>> deleteTodayTalk() {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.delete(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/today-talk?${Strings.date}=${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
        );
      },
    );
  }

  /// 오늘의 운세를 가져오는 함수
  Future<Map<String, dynamic>> getTodayFortune() {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.get(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/today-fortune",
        );
      },
    );
  }

  /**
   *
   * 할 일 관련 함수들
   *
   */

  /// 할 일 정보를 요청하는 함수
  Future<Map<String, dynamic>> getTodos(String fromDate, String toDate) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.get(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/todo?${Strings.fromDate}=$fromDate&${Strings.toDate}=$toDate",
        );
      },
    );
  }

  /// 할 일을 등록하는 함수
  Future<Map<String, dynamic>> postTodo(
    Todo todo,
    String fromDate,
    String toDate,
  ) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.post(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/todo",
          data: {
            Strings.memberId: todo.memberId == -1
                ? await storage.read(key: Strings.memberId)
                : todo.memberId,
            Strings.title: todo.title,
            Strings.timeTag: todo.timeTag,
            Strings.repeat: todo.repeat,
            Strings.memoColor: todo.memoColor,
            Strings.memo: todo.memo,
            Strings.date: todo.date,
            Strings.fromDate: fromDate,
            Strings.toDate: toDate,
          },
        );
      },
    );
  }

  /// 할 일을 업데이트 하는 함수
  Future<Map<String, dynamic>> updateTodo(
    Todo todo,
    int isAfterUpdate,
    String fromDate,
    String toDate,
  ) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/todo/${todo.todoId}",
          data: {
            Strings.memberId: todo.memberId == -1
                ? await storage.read(key: Strings.memberId)
                : todo.memberId,
            Strings.title: todo.title,
            Strings.timeTag: todo.timeTag,
            Strings.repeat: todo.repeat,
            Strings.memo: todo.memo,
            Strings.date: todo.date,
            Strings.fromDate: fromDate,
            Strings.toDate: toDate,
            Strings.isAfterUpdate: isAfterUpdate,
          },
        );
      },
    );
  }

  /// 할 일을 완료 함수
  Future<Map<String, dynamic>> doneTodo(
    Todo todo,
    int isDone,
    String fromDate,
    String toDate,
  ) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.put(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/todo/${todo.todoId}/done",
          data: {
            Strings.date: todo.date,
            Strings.fromDate: fromDate,
            Strings.toDate: toDate,
            Strings.isDone: isDone,
          },
        );
      },
    );
  }

  /// 할 일을 제거하는 함수
  Future<Map<String, dynamic>> deleteTodo(
    Todo todo,
    int isAfterUpdate,
    String fromDate,
    String toDate,
  ) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.delete(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/todo/${todo.todoId}",
          data: {
            Strings.date: todo.date,
            Strings.fromDate: fromDate,
            Strings.toDate: toDate,
            Strings.isAfterDelete: isAfterUpdate,
          },
        );
      },
    );
  }

  /**
   *
   * 편지 함수
   *
   */

  /// 편지들을 조회하는 함수
  Future<Map<String, dynamic>> getLetters() {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.get(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/letter",
        );
      },
    );
  }

  /// 편지를 발송하는 함수
  Future<Map<String, dynamic>> sendLetter(Letter letter) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.post(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/letter",
          data: {
            Strings.content: letter.content,
            Strings.date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
            Strings.toMemberId: letter.toMemberId,
            Strings.envelope: letter.envelope.toString(),
          },
        );
      },
    );
  }

  /**
   *
   *  채팅 관련 함수
   *
   */

  /// 채팅 목록 불러오는 함수
  Future<Map<String, dynamic>> getChats(ChatPagingDTO chatPagingDTO) {
    return _tryRequest(
      () async {
        final Dio auth = await authDio();
        return auth.get(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/message/chats?count=${chatPagingDTO.count}&lastId=${chatPagingDTO.lastId}",
        );
      },
    );
  }

  /// 커넥션 목록 불러오는 함수
  Future<Map<String, dynamic>> getConnections() {
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            queryParameters: {
              'familyId':
                  await RemoteDataSource.storage.read(key: Strings.familyId),
            },
          ),
        ).get(
          "${dotenv.get("CHAT_HTTP")}/connections",
        );
      },
    );
  }

  /// 일반 채팅 보내는 함수
  Future<Map<String, dynamic>> postChat(String chat, {Map? metaData}) {
    return _tryRequestLambda(
      () async {
        final Dio dio = Dio();
        return dio.post(
          "https://api.modak-talk.com/message",
          data: {
            "user_id": int.parse(
              (await storage.read(key: Strings.memberId))!,
            ),
            "family_id": int.parse(
              (await storage.read(key: Strings.familyId))!,
            ),
            "content": chat,
            "metadata": metaData ?? {"type_code": "plain"},
          },
        );
      },
    );
  }

  /// upload url 발급
  Future<Map<String, dynamic>> getMediaUploadUrl() async {
    return _tryRequest(
      () async {
        return await Dio().get(
          "${dotenv.get("CHAT_HTTP")}/media/post-url",
        );
      },
    );
  }

  /// 미디어 업로드 함수
  Future<Map<String, dynamic>> uploadMedia(FormData formData) async {
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            headers: {
              "Content-Type": "multipart/form-data",
              'Connection': 'keep-alive',
              "Accept": "*/*"
            },
          ),
        ).post(dotenv.get("S3_ENDPOINT"), data: formData);
      },
    );
  }

  /**
   *
   *  앨범 관련 함수
   *
   */

  /// 미디어 key name 얻는 함수
  Future<Map<String, dynamic>> getMediaInfoList(int lastId, int count) async {
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            queryParameters: {
              'familyId':
                  await RemoteDataSource.storage.read(key: Strings.familyId),
              'count': count,
              'lastId': lastId,
            },
          ),
        ).get(
          "${dotenv.get("CHAT_HTTP")}/media",
        );
      },
    );
  }

  Future<Map<String, dynamic>> getFaceList() async {
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            queryParameters: {
              'familyId':
                  await RemoteDataSource.storage.read(key: Strings.familyId),
            },
          ),
        ).get(
          "${dotenv.get("CHAT_HTTP")}/media/face/list",
        );
      },
    );
  }

  Future<Map<String, dynamic>> getLabelList() async {
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            queryParameters: {
              'familyId':
                  await RemoteDataSource.storage.read(key: Strings.familyId),
            },
          ),
        ).get(
          "${dotenv.get("CHAT_HTTP")}/media/label/list",
        );
      },
    );
  }

  Future<Map<String, dynamic>> getFaceDetail(
      int lastId, int count, int clusterId) async {
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            queryParameters: {
              'lastId': lastId,
              'familyId':
                  await RemoteDataSource.storage.read(key: Strings.familyId),
              'count': count,
              'clusterId': clusterId,
            },
          ),
        ).get(
          "${dotenv.get("CHAT_HTTP")}/media/face/detail",
        );
      },
    );
  }

  Future<Map<String, dynamic>> getLabelDetail(
      int lastId, int count, String labelName) async {
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            queryParameters: {
              'lastId': lastId,
              'familyId':
                  await RemoteDataSource.storage.read(key: Strings.familyId),
              'count': count,
              'labelName': labelName,
            },
          ),
        ).get(
          "${dotenv.get("CHAT_HTTP")}/media/label/detail",
        );
      },
    );
  }

  /// 미디어 다운로드 url 발급 함수
  Future<Map<String, dynamic>> getMediaDownloadURL(
      List<dynamic> requestList) async {
    return _tryRequest(
      () async {
        return await Dio().post(
          "${dotenv.get("CHAT_HTTP")}/media/get-url",
          data: {
            'list': requestList,
          },
        );
      },
    );
  }

  /**
   *
   * 보조 함수들
   *
   */

  /// storage를 초기화 함
  Future<bool> clearStorage() async {
    await storage.deleteAll();
    return true;
  }

  /// accessToken, refresh Token 검증하는 과정이 포함된 Dio
  /// accessToken 을 포함할 시에 아래 Dio 를 통해 요청
  Future<Dio> authDio() async {
    final Dio dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          options,
          handler,
        ) async {
          String? accessToken = await storage.read(key: Strings.accessToken);
          options.headers[Strings.headerAccessToken] = accessToken;
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.data['code'] == "ExpiredAccessTokenException") {
            Map<String, dynamic> response = await _reIssueAccessToken();
            if (response[Strings.result]) {
              await storage.write(
                key: Strings.accessToken,
                value: response[Strings.response]
                    .headers[Strings.headerAccessToken]![0],
              );
              final clonedRequest = await Dio().request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: {
                    Strings.headerAccessToken:
                        await storage.read(key: Strings.accessToken),
                  },
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              return handler.resolve(clonedRequest);
            }
            if (response[Strings.message] == "ExpiredRefreshTokenException") {
              storage.deleteAll();
              Get.offAllNamed("/auth/landing");
            }
          }
          return handler.next(error);
        },
      ),
    );

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
          value: response.headers[Strings.headerAccessToken]![0],
        );
      }
      if (isUpdatingRefreshToken) {
        await storage.write(
          key: Strings.refreshToken,
          value: response.headers[Strings.headerRefreshToken]![0],
        );
      }
      if (isUpdatingMemberId) {
        await storage.write(
          key: Strings.memberId,
          value: response.data['data']['memberResult'][Strings.memberId]
              .toString(),
        );
      }
      if (isUpdatingFamilyId) {
        await storage.write(
          key: Strings.familyId,
          value: response.data['data'][Strings.memberResult][Strings.familyId]
              .toString(),
        );
      }
    } catch (e) {
      if (e is DioError) {
        log("error ${e.response}");
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
    return _tryRequest(
      () async {
        return await Dio(
          BaseOptions(
            headers: {
              Strings.headerHost: "www.never.com",
              Strings.headerAccessToken:
                  await storage.read(key: Strings.accessToken),
              Strings.headerRefreshToken:
                  await storage.read(key: Strings.refreshToken),
            },
          ),
        ).get(
          "${dotenv.get(Strings.apiEndPoint)}/api/v2/token/reissue",
        );
      },
    );
  }

  /// lambda 함수 exception 처리를 도와주는 함수
  Future<Map<String, dynamic>> _tryRequestLambda(
    RequestFunction function,
  ) async {
    try {
      await function.call();
    } catch (e) {
      if (e is DioError) {
        return {
          Strings.result: false,
        };
      }
    }
    return {
      Strings.result: true,
    };
  }
}
