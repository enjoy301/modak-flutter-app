import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';

class IconBadgeWidget extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final int notificationCount;

  const IconBadgeWidget({
    Key? key,
    this.onTap,
    required this.iconData,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData),
              ],
            ),
            if (notificationCount != 0)
              Positioned(
                top: 3,
                right: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  alignment: Alignment.center,
                  child: Text(
                    '$notificationCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Font.size_caption,
                      fontWeight: Font.weight_bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
