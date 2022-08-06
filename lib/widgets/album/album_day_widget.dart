import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';

class AlbumDayWidget extends StatefulWidget {
  const AlbumDayWidget({Key? key}) : super(key: key);

  @override
  State<AlbumDayWidget> createState() => _AlbumDayWidgetState();
}

class _AlbumDayWidgetState extends State<AlbumDayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, bottom: 12),
          child: Text("2022년 8월 5일",
              style: TextStyle(
                color: Colors.black,
                fontSize: Font.size_mediumText,
                fontWeight: Font.weight_medium,
              )),
        ),
        IgnorePointer(
          child: GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
            children: [
              Image.asset("lib/assets/images/others/mac.png",
                  fit: BoxFit.cover),
              Image.asset("lib/assets/images/others/test.png",
                  fit: BoxFit.cover),
              Image.asset("lib/assets/images/others/test.png",
                  fit: BoxFit.cover),
              Image.asset("lib/assets/images/others/mac.png",
                  fit: BoxFit.cover),
              Image.asset("lib/assets/images/others/test.png",
                  fit: BoxFit.cover),
              Image.asset("lib/assets/images/others/mac.png",
                  fit: BoxFit.cover),
            ],
          ),
        ),
      ],
    );
  }
}
