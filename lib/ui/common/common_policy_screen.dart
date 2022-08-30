import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class CommonPolicyScreen extends StatefulWidget {
  const CommonPolicyScreen({Key? key, required this.policyType})
      : super(key: key);

  final PolicyType policyType;

  @override
  // ignore: no_logic_in_create_state
  State<CommonPolicyScreen> createState() => _CommonPolicyScreenState();
}

class _CommonPolicyScreenState extends State<CommonPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<PolicyType, dynamic> data = {
      PolicyType.private: {
        "title": "개인 정보",
        "contents": Strings.privateInformation,
        "agreementText": "개인정보 수집, 이용에 동의합니다.",
        "isChecked": context.watch<AuthProvider>().isPrivateInformationAgreed,
        "function": (bool? value) {
          context.read<AuthProvider>().toggleIsPrivateInformationAgreed();
        },
      },
      PolicyType.operating: {
        "title": "운영 정책",
        "contents": Strings.operatingPolicy,
        "agreementText": "Modak 운영 정책에 동의합니다.",
        "isChecked": context.watch<AuthProvider>().isOperatingPolicyAgreed,
        "function": (bool? value) {
          context.read<AuthProvider>().toggleIsOperatingPolicyAgreed();
        },
      },
    };
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
          title: data[widget.policyType]['title'],
          leading: FunctionalIcon.close,
          onClickLeading: () {
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Text(data[widget.policyType]['contents']),
        ),
      ),
      bottomNavigationBar:
          Consumer<AuthProvider>(builder: (context, provider, build) {
        return SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: data[widget.policyType]['isChecked'],
                  onChanged: data[widget.policyType]['function']),
              Text(data[widget.policyType]['agreementText']),
            ],
          ),
        );
      }),
    );
  }
}
