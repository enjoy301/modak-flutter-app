import 'package:flutter/cupertino.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProviderController {
  static startProviders(BuildContext context) async {
    await Future(() => context.read<HomeProvider>().init());
    await Future(() => context.read<TodoProvider>().init());
    await Future(() => context.read<ChatProvider>().init());
    await Future(() => context.read<AlbumProvider>().init());
    await Future(() => context.read<UserProvider>().init());
  }

  static refreshProviders(BuildContext context) async {
    await Future(() => context.read<UserProvider>().clear());
  }
}
