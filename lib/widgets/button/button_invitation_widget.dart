import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/dynamic_link_util.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonInvitationWidget extends StatelessWidget {
  const ButtonInvitationWidget({Key? key, required this.type})
      : super(key: key);

  final String type;
  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, dynamic>> data = {
      "phone": {
        "title": "전화번호로 초대하기",
        "image": "lib/assets/images/others/phone_invitation.png",
        "onPressed": () async {
          final PhoneContact contact =
              await FlutterContactPicker.pickPhoneContact();
          String? phoneNumber = contact.phoneNumber!.number;
          if (phoneNumber != null) {
            print(phoneNumber);
            final Uri smsLaunchUri = Uri(
              scheme: 'sms',
              path: phoneNumber,
              queryParameters: <String, String>{
                'body': """
${UserProvider.family_id}님께서 당신을 모닥에 초대하셨습니다.
 링크를 클릭하여 가족 채팅방에 참여하세요.
  앱이 없다면 다운로드 링크로 이동합니다.
  ${await DynamicLinkUtil.getInvitationLink()}
  """,
              },
            );
            launchUrl(smsLaunchUri);
          }
        },
      },
      "kakao": {
        "title": "카카오톡으로 초대하기",
        "image": "lib/assets/images/others/kakao_invitation.png",
        "onPressed": () async {
          final TextTemplate defaultFeed = TextTemplate(
              buttonTitle: "가족 방으로 이동하기",
              text:
                  "모닥에서 ${UserProvider.family_id} 님이 당신을 가족방에 초대하셨습니다. 클릭하여 방으로 이동하세요. 아직 앱이 설치되있지 않을시 스토어로 이동합니다.",
              link: Link(
                webUrl: await DynamicLinkUtil.getInvitationLink(),
                mobileWebUrl: await DynamicLinkUtil.getInvitationLink(),
              ));
          try {
            Uri uri =
                await ShareClient.instance.shareDefault(template: defaultFeed);
            await ShareClient.instance.launchKakaoTalk(uri);
            print('카카오톡 공유 완료');
          } catch (error) {
            print('카카오톡 공유 실패 $error');
          }
        }
      },
    };
    return ElevatedButton(
      onPressed: data[type]!['onPressed'],
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ))),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 15,
        ),
        child: Row(
          children: [
            Image.asset(
              data[type]!["image"]!,
              width: 50,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                data[type]!["title"]!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Font.size_mediumText,
                  fontWeight: Font.weight_medium,
                ),
              ),
            ),
            Expanded(child: Text("")),
            IconGradientWidget(
                LightIcons.ArrowRightCircle, 30, Coloring.sub_purple)
          ],
        ),
      ),
    );
  }
}
