import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';

void modalInputWidget(BuildContext context, {String title = "직접 입력", Function(String text)? onPressed}) {
  onPressed ??= (String text) {
    Get.back();
  };
  final TextEditingController textEditingController = TextEditingController();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(32, 32),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    onPressed: () {
                      Get.back();
                    },
                    child: Image.asset(
                      "lib/assets/functional_image/ic_close.png",
                      width: 32,
                      height: 32,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: Font.size_largeText, fontWeight: Font.weight_bold),
                  ),
                  SizedBox(
                    width: 32,
                    height: 32,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 16),
                child: InputTextWidget(
                  textEditingController: textEditingController,
                  hint: "입력해 주세요",
                ),
              ),
              ButtonMainWidget(
                title: "확인",
                onPressed: () {
                  onPressed?.call(textEditingController.text);
                  Get.back();
                },
                height: 50,
              )
            ],
          ),
        );
      });
}
