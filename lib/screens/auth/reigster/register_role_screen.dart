import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
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
        child: Column(
          children: [
            Text("역할을 선택하세요", style: TextStyle(fontWeight: Font.weight_semiBold),),
            GridView(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                FamilyType.dad,
                FamilyType.mom,
                FamilyType.son,
                FamilyType.dau,
              ].map((family) {
                return Container(
                  color: family == provider.role ? Colors.red : Colors.black,
                  child: GestureDetector(
                    onTap: () {
                      provider.setRole(family);
                    },
                    child: Image.asset("lib/assets/img.png"),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }
}

