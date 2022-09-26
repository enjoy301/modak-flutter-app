import 'dart:developer';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/model/chat_model.dart';

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

  Future<Map<String, dynamic>> postChat(ChatModel chat) async {
    Map<String, dynamic> response = await remoteDataSource!.postChat(chat);

    log("repository postChat ${response.toString()}");

    return {Strings.message: Strings.success};
  }
}
