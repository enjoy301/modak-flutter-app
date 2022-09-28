import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';

class CommonPolicyScreen extends StatefulWidget {
  const CommonPolicyScreen(
      {Key? key, required this.policyType, this.isChecked = false, this.withCheck = true})
      : super(key: key);

  final PolicyType policyType;
  final bool isChecked;
  final bool withCheck;

  @override
  State<CommonPolicyScreen> createState() => _CommonPolicyScreenState();
}

class _CommonPolicyScreenState extends State<CommonPolicyScreen> {
  late bool isChecked;

  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<PolicyType, dynamic> data = {
      PolicyType.private: {
        "title": "개인 정보",
        "contents": Strings.privateInformation,
        "agreementText": "개인정보 수집, 이용에 동의합니다.",
      },
      PolicyType.operating: {
        "title": "운영 정책",
        "contents": Strings.operatingPolicy,
        "agreementText": "Modak 운영 정책에 동의합니다.",
      },
    };
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, isChecked);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: headerDefaultWidget(
            title: data[widget.policyType]['title'],
            leading: FunctionalIcon.close,
            onClickLeading: () {
              Navigator.pop(context, isChecked);
            }),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Text(data[widget.policyType]['contents']),
          ),
        ),
        bottomNavigationBar: widget.withCheck ? SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) => setState(() {
                        isChecked = value!;
                      })),
              Text(data[widget.policyType]['agreementText']),
            ],
          ),
        ) : null,
      ),
    );
  }
}
