import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/model/letter.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';

class ChatRepository {
  ChatRepository._create();

  static Future<ChatRepository> create() async {
    ChatRepository albumRepository = ChatRepository._create();
    localDataSource ??= await LocalDataSource.create();
    remoteDataSource ??= RemoteDataSource();
    return albumRepository;
  }

  static LocalDataSource? localDataSource;
  static RemoteDataSource? remoteDataSource;

  Future<Map<String, dynamic>> getLetters() async {
    Map<String, dynamic> response = await remoteDataSource!.getLetters();
    if (response[Strings.result]) {
      List<dynamic> data =
          response[Strings.response].data['data']['sentLetterList'];
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
}
