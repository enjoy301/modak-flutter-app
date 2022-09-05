import 'package:flutter/material.dart';
import 'package:modak_flutter_app/data/model/user.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
class UserProvider extends ChangeNotifier {

  UserProvider({bool initiate = true}) {
    if (initiate) {
      init();
    }
  }

  init() async {
    _userRepository = await UserRepository.create();
    _user = _userRepository.getMe()!;
  }

  late UserRepository _userRepository;

  User? _user;
  User? get user => _user;
  set user(User? user) {
    if (user == null) return ;
    _user = user;
    _userRepository.setMe(user);
    notifyListeners();
  }
}
