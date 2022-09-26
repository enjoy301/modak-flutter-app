import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/model/letter.dart';
import 'package:modak_flutter_app/data/model/user.dart';
import 'package:modak_flutter_app/data/repository/chat_repository.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ChatLetterVM extends ChangeNotifier {

  ChatLetterVM() {
    init();
  }

  init() async {
    _chatRepository = await ChatRepository.create();
  }

  late final ChatRepository _chatRepository;

  /// 편지 저장
  List<Letter> letters = [];
  List<Letter> lettersSent = [];
  List<Letter> lettersReceived = [];

  Future<bool> getLetters(BuildContext context) async {
    Map<String, dynamic> response = await _chatRepository.getLetters();
    switch (response[Strings.message]) {
      case Strings.success:
        letters.clear();
        lettersSent.clear();
        lettersReceived.clear();
        for (Letter letter in response[Strings.response]["letters"]) {
          letters.add(letter);
          // ignore: use_build_context_synchronously
          if (letter.fromMemberId == context.read<UserProvider>().me!.memberId) {
            lettersSent.add(letter);
          } else {
            lettersReceived.add(letter);
          }
        }
        notifyListeners();
        Fluttertoast.showToast(msg: "성공적으로 편지를 받아왔습니다");
        return true;
      case Strings.fail:
        Fluttertoast.showToast(msg: "편지를 받아오는데 실패하였습니다");
        return false;
    }
    return false;
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
        Fluttertoast.showToast(msg: "메시지 전송 성공");
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
