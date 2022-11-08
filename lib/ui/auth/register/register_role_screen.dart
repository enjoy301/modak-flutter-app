import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_VM.dart';

class RegisterRoleScreen extends StatefulWidget {
  const RegisterRoleScreen({Key? key, required this.provider}) : super(key: key);

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
      width: double.infinity,
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
            Column(
              children: [
                [Strings.mom, "엄마"],
                [Strings.dad, "아빠"],
                [Strings.son, "아들"],
                [Strings.dau, "딸"]
              ].map((family) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: GestureDetector(
                    onTap: () {
                      widget.provider.role = family[0];
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Coloring.gray_50,
                          gradient: family[0] == widget.provider.role ? Coloring.sub_purple : null,
                          borderRadius: BorderRadius.circular(45),
                          border:
                              family[0] == widget.provider.role ? null : Border.all(color: Coloring.gray_30, width: 1)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: family[0] == widget.provider.role ? 22 : 20),
                        child: Text(
                          family[1],
                          style: TextStyle(
                            color: family[0] == widget.provider.role ? Colors.white : Coloring.gray_20,
                            fontSize: Font.size_h4,
                            fontWeight: Font.weight_bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
