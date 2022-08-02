import 'package:flutter/material.dart';

class IconGradientWidget extends StatelessWidget {
  const IconGradientWidget(this.icon, this.size, this.gradient, {Key? key, this.scale = 1.2})
      : super(key: key);

  final IconData icon;
  final double size;
  final Gradient gradient;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * scale,
        height: size * scale,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
