import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/button/button_cancel_widget.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';

void themeModalWidget(
  BuildContext context, {
  title = "제목",
  String? des,
  Function? onOkPress,
  Function? onCancelPress,
  String? okText,
  String? cancelText,
}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text(
              title,
              style: EasyStyle.text(Colors.black, Font.size_subTitle, Font.weight_semiBold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (des != null)
                  Text(
                    des ?? "",
                    style: EasyStyle.text(Colors.black, Font.size_smallText, Font.weight_regular),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: des != null ? 24 : 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          flex: 10,
                          child: ButtonCancelWidget(
                              title: cancelText ?? "취소",
                              height: 40,
                              onPressed: () {
                                if (onCancelPress != null) {
                                  onCancelPress.call();
                                }
                                Get.back();
                              })),
                      Expanded(
                        flex: 2,
                        child: SizedBox.shrink(),
                      ),
                      Expanded(
                        flex: 20,
                        child: ButtonMainWidget(
                            title: okText ?? "완료",
                            height: 40,
                            onPressed: () {
                              if (onOkPress != null) {
                                onOkPress.call();
                              }
                              Get.back();
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
}
