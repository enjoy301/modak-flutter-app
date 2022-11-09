import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';

/// name, icon, onTap
void themePositionListWidget(
  BuildContext context, {
  required List<Map<String, dynamic>> itemList,
  required TapDownDetails details,
}) async {
  Offset tapPosition = details.globalPosition;
  // This function will be called when you long press on the blue box or the image
  final RenderObject? overlay = Overlay.of(context)?.context.findRenderObject();

  final result = await showMenu(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      // Show the context menu at the tap location
      position: RelativeRect.fromRect(
          Rect.fromLTWH(tapPosition.dx, tapPosition.dy, 30, 30),
          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
              overlay.paintBounds.size.height)),

      // set a list of choices for the context menu
      items: itemList
          .map(
            (Map<String, dynamic> item) => PopupMenuItem(
              child: TextButton(
                onPressed: item['onTap'],
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Coloring.gray_50,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      item['name'],
                      style: EasyStyle.text(Coloring.gray_0,
                          Font.size_mediumText, Font.weight_semiBold),
                    ),
                    Expanded(child: SizedBox.shrink()),
                    item['icon'] ?? SizedBox.shrink()
                  ],
                ),
              ),
            ),
          )
          .toList());

  // Implement the logic for each choice here
}
