import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget(
      {Key? key, required this.user, required this.onPressed})
      : super(key: key);

  final User? user;
  final Function() onPressed;

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 18,
      ),
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [Shadowing.bottom]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Image.asset(
              "lib/assets/images/family/profile/${widget.user?.role.toLowerCase()}_profile.png",
              width: 56,
              height: 56,
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ScalableTextWidget(
                        widget.user != null ? widget.user!.name : "",
                        maxLines: 5,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Font.size_largeText,
                          fontWeight: Font.weight_semiBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6),
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: CircleAvatar(
                            backgroundColor: widget.user != null
                                ? widget.user!.color.toColor()
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      widget.user != null
                          ? "${widget.user!.role} | ${Date.getFormattedDate(dateTime: DateTime.parse(widget.user!.birthDay), format: "M월d일생")}"
                          : "",
                      style: TextStyle(
                        color: Coloring.gray_10,
                        fontSize: Font.size_smallText,
                        fontWeight: Font.weight_regular,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Icon(LightIcons.ArrowRight2)
        ],
      ),
    );
  }
}
