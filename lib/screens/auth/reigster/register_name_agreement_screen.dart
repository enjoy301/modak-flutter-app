import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterNameAgreementScreen extends StatefulWidget {
  const RegisterNameAgreementScreen({Key? key}) : super(key: key);

  @override
  State<RegisterNameAgreementScreen> createState() =>
      _RegisterNameAgreementScreenState();
}

class _RegisterNameAgreementScreenState
    extends State<RegisterNameAgreementScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          Text("이름"),
          TextFormField(
            initialValue: provider.name,
            onChanged: (String name) {
              provider.setName(name);
            },
          ),
          TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    minTime: DateTime.utc(1950),
                    maxTime: DateTime.now(),
                    currentTime: provider.birthDay ?? DateTime.now(),
                    onConfirm: (DateTime dateTime) {
                  provider.setBirthDay(dateTime);
                });
              },
              child: Text(provider.birthDay != null
                  ? "${provider.birthDay!.year}년 ${provider.birthDay!.month}월 ${provider.birthDay!.day}일"
                  : "날짜를 입력해주세요")),
          Row(
            children: [
              Checkbox(
                  value: provider.isPrivateInformationAgreed,
                  onChanged: (bool? value) {
                    provider.toggleIsPrivateInformationAgreed();
                  }),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: provider.isOperatingPolicyAgreed,
                  onChanged: (bool? value) {
                    provider.toggleIsOperatingPolicyAgreed();
                  }),
            ],
          ),
        ],
      );
    });
  }
}
