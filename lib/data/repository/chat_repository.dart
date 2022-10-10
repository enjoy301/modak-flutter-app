import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/model/letter.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'dart:developer';
import 'package:modak_flutter_app/data/model/chat.dart';

class ChatRepository {
  ChatRepository._create();

  static Future<ChatRepository> create() async {
    ChatRepository chatRepository = ChatRepository._create();
    localDataSource ??= await LocalDataSource.create();
    remoteDataSource ??= RemoteDataSource();
    return chatRepository;
  }

  static LocalDataSource? localDataSource;
  static RemoteDataSource? remoteDataSource;

  Future<Map<String, dynamic>> getLetters() async {
    Map<String, dynamic> response = await remoteDataSource!.getLetters();
    if (response[Strings.result]) {
      List<dynamic> data =
          response[Strings.response].data['data']['letterList'];
      List<Letter> letterList = [];
      for (dynamic rawLetter in data) {
        letterList.add(Letter(
            fromMemberId: rawLetter[Strings.fromMemberId],
            toMemberId: rawLetter[Strings.toMemberId],
            content: rawLetter[Strings.content],
            envelope: rawLetter[Strings.envelope].toString().toEnvelopeType() ??
                EnvelopeType.red,
            date: rawLetter[Strings.date]));
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
        await remoteDataSource!.getChats(count, lastId);

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
    Map<String, dynamic> response = await remoteDataSource!.sendLetter(letter);
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
    Map<String, dynamic> response = await remoteDataSource!.getConnections();

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
    Map<String, dynamic> response = await remoteDataSource!.postChat(chat);

    return {Strings.message: Strings.success};
  }
}
