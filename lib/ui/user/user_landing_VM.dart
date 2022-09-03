import 'package:flutter/foundation.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/model/user.dart';

class UserLandingVM extends ChangeNotifier {
  init() async {
    _localDataSource = await LocalDataSource.create();
    user = _localDataSource.getMe()!;
  }

  late final LocalDataSource _localDataSource;
  User? user;
}