import 'package:dio/dio.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/dto/letter.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';

class ChatRepository {
  ChatRepository._privateConstructor() {
    localDataSource = LocalDataSource();
    remoteDataSource = RemoteDataSource();
  }

  factory ChatRepository() {
    return _instance;
  }

  static final ChatRepository _instance = ChatRepository._privateConstructor();
  static late final LocalDataSource localDataSource;
  static late final RemoteDataSource remoteDataSource;

  /// 편지 리스트 받아오기
  Future<Map<String, dynamic>> getLetters() async {
    Map<String, dynamic> response = await remoteDataSource.getLetters();
    if (response[Strings.result]) {
      List<dynamic> data =
          response[Strings.response].data['data']['letterList'];
      List<Letter> letterList = [];
      for (dynamic rawLetter in data) {
        letterList.add(
          Letter(
            fromMemberId: rawLetter[Strings.fromMemberId],
            toMemberId: rawLetter[Strings.toMemberId],
            content: rawLetter[Strings.content],
            envelope: rawLetter[Strings.envelope].toString().toEnvelopeType() ??
                EnvelopeType.red,
            date: rawLetter[Strings.date],
          ),
        );
      }
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "letters": letterList,
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> getChats(int count, int lastId) async {
    Map<String, dynamic> response =
        await remoteDataSource.getChats(count, lastId);

    if (response[Strings.result]) {
      return {
        Strings.response: {
          "data": response["response"].data["data"]["result"],
        },
        Strings.message: Strings.success,
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> sendLetter(Letter letter) async {
    Map<String, dynamic> response = await remoteDataSource.sendLetter(letter);
    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
      };
    }
    return {
      Strings.message: Strings.fail,
    };
  }

  Future<Map<String, dynamic>> getConnections() async {
    Map<String, dynamic> response = await remoteDataSource.getConnections();

    if (response[Strings.result]) {
      return {
        Strings.response: {
          "data": response["response"].data['data']['result'],
        },
        Strings.message: Strings.success,
      };
    }

    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> postChat(String chat) async {
    Map<String, dynamic> response = await remoteDataSource.postChat(chat);

    return {Strings.message: Strings.success};
  }

  /// 미디어 업로드 url 발급
  Future<Map<String, dynamic>> getMediaUrl() async {
    Map<String, dynamic> response = await remoteDataSource.getMediaUploadUrl();

    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "url": response,
        },
      };
    }

    return {
      Strings.message: Strings.fail,
    };
  }

  /// 미디어 업로드 함수
  Future<Map<String, dynamic>> uploadMedia(
    Map<String, dynamic> mediaUrlData,
    MultipartFile file,
    String type,
    int imageCount,
    String memberId,
    String familyId,
  ) async {
    String xAmzAlgorithm = mediaUrlData['fields']['x-amz-algorithm'];
    String xAmzCredential = mediaUrlData['fields']['x-amz-credential'];
    String xAmzDate = mediaUrlData['fields']['x-amz-date'];
    String xAmzSecurityToken = mediaUrlData['fields']['x-amz-security-token'];
    String policy = mediaUrlData['fields']['policy'];
    String xAmzSignature = mediaUrlData['fields']['x-amz-signature'];
    int xAmzMetaImageCount = imageCount;

    FormData formData = FormData.fromMap(
      {
        "key": "$familyId/${DateTime.now().millisecondsSinceEpoch}/Modak.zip",
        "x-amz-algorithm": xAmzAlgorithm.trim(),
        "x-amz-credential": xAmzCredential.trim(),
        "x-amz-date": xAmzDate.trim(),
        "x-amz-security-token": xAmzSecurityToken.trim(),
        "policy": policy.trim(),
        "x-amz-signature": xAmzSignature.trim(),
        "x-amz-meta-user_id": memberId,
        "x-amz-meta-family_id": familyId,
        "x-amz-meta-image_count": xAmzMetaImageCount,
        "file": file,
      },
    );

    Map<String, dynamic> response =
        await remoteDataSource.uploadMedia(formData);

    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
      };
    }

    return {
      Strings.message: Strings.fail,
    };
  }
}
