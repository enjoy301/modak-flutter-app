import 'package:flutter/material.dart';

class Shadowing {

  static final BoxShadow yellow = BoxShadow(
      color: Color.fromRGBO(255, 185, 146, 0.3),
      blurRadius: 22,
      offset: Offset(0, 10));

  static final BoxShadow purple = BoxShadow(
      color: Color.fromRGBO(197, 139, 242, 0.3),
      blurRadius: 22,
      offset: Offset(0, 10));

  static final BoxShadow blue = BoxShadow(
      color: Color.fromRGBO(121, 231, 255, 0.3),
      blurRadius: 22,
      offset: Offset(0, 10));

  static final BoxShadow grey = BoxShadow(
      color: Color.fromRGBO(29, 22, 23, 0.07),
      blurRadius: 22,
      offset: Offset(0, 10));

  static final BoxShadow bottom = BoxShadow(
      color: Color.fromRGBO(29, 22, 23, 0.1),
      blurRadius: 22,
      offset: Offset(0, 10));
}
