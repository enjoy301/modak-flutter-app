import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/letter.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/data/repository/chat_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/datasource/remote_datasource.dart';

class ChatLetterVM extends ChangeNotifier {
  ChatLetterVM() {
    init();
  }

  init() async {
    _chatRepository = ChatRepository();
  }

  late final ChatRepository _chatRepository;

  /// 편지 저장
  List<Letter> letters = [];
  List<Letter> lettersSent = [];
  List<Letter> lettersReceived = [];

  Future getLetters() async {
    String memberId =
        (await RemoteDataSource.storage.read(key: Strings.memberId))!;
    Map<String, dynamic> response = await _chatRepository.getLetters();
    switch (response[Strings.message]) {
      case Strings.success:
        letters.clear();
        lettersSent.clear();
        lettersReceived.clear();
        for (Letter letter in response[Strings.response]["letters"]) {
          letters.add(letter);
          // ignore: use_build_context_synchronously
          if (letter.fromMemberId.toString() == memberId) {
            lettersSent.add(letter);
          } else {
            lettersReceived.add(letter);
          }
        }
        notifyListeners();
        break;
      case Strings.fail:
        break;
    }
  }

  /// 편지 작성 중
  User? _toMember;
  User? get toMember => _toMember;
  set toMember(User? toMember) {
    _toMember = toMember;
    notifyListeners();
  }

  String _content = "";
  String get content => _content;
  set content(String content) {
    _content = content;
    notifyListeners();
  }

  EnvelopeType _envelope = EnvelopeType.red;
  EnvelopeType get envelope => _envelope;
  set envelope(EnvelopeType envelope) {
    _envelope = envelope;
    notifyListeners();
  }

  bool getFirstPageValidity() {
    return _content.isNotEmpty && _toMember != null;
  }

  Future<bool> sendLetter(BuildContext context) async {
    Letter letter = Letter(
        fromMemberId: context.read<UserProvider>().me!.memberId,
        toMemberId: _toMember!.memberId,
        content: _content,
        envelope: _envelope,
        date: DateFormat("yyyy-MM-dd").format(DateTime.now()));
    Map<String, dynamic> response = await _chatRepository.sendLetter(letter);
    switch (response[Strings.message]) {
      case Strings.success:
        lettersSent.add(letter);
        notifyListeners();
        clearLetter();
        return true;
      case Strings.fail:
        Fluttertoast.showToast(msg: "편지 전송 실패");
        return false;
    }
    return false;
  }

  clearLetter() {
    _toMember = null;
    _content = "";
    _envelope = EnvelopeType.red;
  }
}
