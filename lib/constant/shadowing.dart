import 'package:flutter/material.dart';

class Shadowing {
  static const BoxShadow yellow = BoxShadow(
      color: Color.fromRGBO(255, 185, 146, 0.3),
      blurRadius: 22,
      offset: Offset(0, 10));

  static const BoxShadow purple = BoxShadow(
      color: Color.fromRGBO(197, 139, 242, 0.3),
      blurRadius: 22,
      offset: Offset(0, 10));

  static const BoxShadow blue = BoxShadow(
      color: Color.fromRGBO(121, 231, 255, 0.3),
      blurRadius: 22,
      offset: Offset(0, 10));

  static const BoxShadow grey = BoxShadow(
      color: Color.fromRGBO(29, 22, 23, 0.07),
      blurRadius: 22,
      offset: Offset(0, 10));

  static const BoxShadow bottom = BoxShadow(
      color: Color.fromRGBO(29, 22, 23, 0.1),
      blurRadius: 22,
      offset: Offset(0, 10));
}
