import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';

class AlbumLandingScreen extends StatelessWidget {
  const AlbumLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextButton(onPressed: () {}, child: Text("Album landing screen"))),
    );
  }
}
