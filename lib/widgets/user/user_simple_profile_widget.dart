import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';

class UserSimpleProfileWidget extends StatefulWidget {
  const UserSimpleProfileWidget({Key? key, required this.family}) : super(key: key);

  final FamilyType family;

  @override
  State<UserSimpleProfileWidget> createState() => _UserSimpleProfileWidgetState();
}

class _UserSimpleProfileWidgetState extends State<UserSimpleProfileWidget> {
  Map<FamilyType, dynamic> data = {
    FamilyType.dad: {
      "image": "lib/assets/images/family/profile/dad_profile.png",
    },
    FamilyType.mom: {
      "image": "lib/assets/images/family/profile/mom_profile.png",
    },
    FamilyType.son: {
      "image": "lib/assets/images/family/profile/son_profile.png",
    },
    FamilyType.dau: {
      "image": "lib/assets/images/family/profile/dau_profile.png",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Image.asset(
              data[widget.family]['image'],
              width: 56,
              height: 56,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "가족 1",
              style: TextStyle(
                color: Coloring.gray_10,
                fontSize: Font.size_smallText,
                fontWeight: Font.weight_regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
