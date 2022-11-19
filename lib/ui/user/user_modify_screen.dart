import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/user/user_modify_VM.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:provider/provider.dart';

import '../../assets/icons/light/LightIcons_icons.dart';
import '../../constant/coloring.dart';
import '../../constant/enum/general_enum.dart';
import '../../constant/font.dart';
import '../../constant/strings.dart';
import '../../widgets/button/button_main_widget.dart';
import '../../widgets/common/checkbox_widget.dart';
import '../../widgets/header/header_default_widget.dart';
import '../../widgets/input/input_color_widget.dart';
import '../../widgets/input/input_date_widget.dart';
import '../../widgets/input/input_select_widget.dart';
import '../../widgets/input/input_text_widget.dart';

class UserModifyScreen extends StatefulWidget {
  const UserModifyScreen({Key? key}) : super(key: key);

  @override
  State<UserModifyScreen> createState() => _UserModifyScreenState();
}

class _UserModifyScreenState extends State<UserModifyScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return ChangeNotifierProvider(
      create: (_) => UserModifyVM(),
      child: Consumer2<UserProvider, UserModifyVM>(
        builder: (context, userProvider, provider, child) {
          return FutureBuilder(
            future: Future<void>(
              () async {
                await provider.init();
                controller.text = provider.me!.name;
              },
            ),
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  appBar: headerDefaultWidget(
                    title: "수정 하기",
                    leading: FunctionalIcon.close,
                    onClickLeading: () {
                      Navigator.pop(context);
                    },
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(
                      top: 32,
                      right: 30,
                      left: 30,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.asset(
                                "lib/assets/images/family/profile/${provider.isLoaded ? provider.me!.role.toLowerCase() : userProvider.me!.role.toLowerCase()}_profile.png",
                                width: 110,
                                height: 110,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 48,
                              bottom: 16,
                            ),
                            child: Text(
                              "기본 정보",
                              style: TextStyle(
                                color: Coloring.gray_10,
                                fontSize: Font.size_mediumText,
                                fontWeight: Font.weight_semiBold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 13),
                            child: InputTextWidget(
                              onChanged: (String name) {
                                provider.setName(name);
                              },
                              textEditingController: controller,
                              isSuffix: provider.isLoaded ? provider.me!.name.isNotEmpty : false,
                              onClickSuffix: () {
                                provider.setName("");
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 13),
                            child: InputSelectWidget(
                              title: "가족 역할",
                              contents: provider.isLoaded ? provider.me!.role.toDisplayString() : "",
                              isFilled: true,
                              buttons: {
                                "아빠": () {
                                  provider.setRole(Strings.dad);
                                },
                                "엄마": () {
                                  provider.setRole(Strings.mom);
                                },
                                "아들": () {
                                  provider.setRole(Strings.son);
                                },
                                "딸": () {
                                  provider.setRole(Strings.dau);
                                },
                              },
                              leftIconData: LightIcons.Profile,
                            ),
                          ),
                          InputColorWidget(
                            color: provider.isLoaded ? provider.me!.color.toColor()! : Colors.white,
                            onColorChanged: (Color color) {
                              provider.setColor(color);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 48,
                              bottom: 16,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "생일 정보",
                                  style: TextStyle(
                                    color: Coloring.gray_10,
                                    fontSize: Font.size_mediumText,
                                    fontWeight: Font.weight_semiBold,
                                  ),
                                ),
                                Expanded(child: Text("")),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: CheckboxWidget(
                                      value: provider.isLoaded ? provider.me!.isLunar : false,
                                      onChanged: (bool? value) {
                                        provider.setLunar(value!);
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Text(
                                    "음력",
                                    style: TextStyle(
                                      color: Coloring.gray_10,
                                      fontSize: Font.size_smallText,
                                      fontWeight: Font.weight_regular,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InputDateWidget(
                            title: "생일",
                            contents: provider.isLoaded ? provider.me!.birthDay : "",
                            currTime: provider.isLoaded ? DateTime.parse(provider.me!.birthDay) : DateTime.now(),
                            onChanged: (DateTime dateTime) {
                              provider.setBirthDay(dateTime);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.only(right: 30, bottom: 50, left: 30),
                    child: ButtonMainWidget(
                      title: "수정 완료",
                      onPressed: () {
                        provider.onModifyClick(context);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
