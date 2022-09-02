import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_VM.dart';
import 'package:modak_flutter_app/widgets/auth/auth_role_widget.dart';
import 'package:provider/provider.dart';

class RegisterRoleScreen extends StatefulWidget {
  const RegisterRoleScreen({Key? key, required this.provider})
      : super(key: key);

  final AuthRegisterVM provider;

  @override
  State<RegisterRoleScreen> createState() => _RegisterRoleScreenState();
}

class _RegisterRoleScreenState extends State<RegisterRoleScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              children: [Strings.dad, Strings.mom, Strings.son, Strings.dau]
                  .map((family) {
                return GestureDetector(
                    onTap: () {
                      widget.provider.role = family;
                    },
                    child: AuthRoleWidget(
                      family: family,
                      isChecked: family == widget.provider.role,
                    ));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
