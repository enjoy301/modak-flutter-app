import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:modak_flutter_app/widgets/auth/auth_role_widget.dart';
import 'package:provider/provider.dart';

class RegisterRoleScreen extends StatefulWidget {
  const RegisterRoleScreen({Key? key}) : super(key: key);

  @override
  State<RegisterRoleScreen> createState() => _RegisterRoleScreenState();
}

class _RegisterRoleScreenState extends State<RegisterRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 30.0, bottom: 150.0, left: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  "가족 중 당신의 역할을 무엇인가요?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Font.size_largeText,
                    fontWeight: Font.weight_semiBold,
                  ),
                ),
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7),
                children: [
                  FamilyType.dad,
                  FamilyType.mom,
                  FamilyType.dau,
                  FamilyType.son,
                ].map((family) {
                  return GestureDetector(
                      onTap: () {
                        provider.setRole(family);
                      },
                      child: AuthRoleWidget(
                        family: family,
                        isChecked: family == provider.role,
                      ));
                }).toList(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
