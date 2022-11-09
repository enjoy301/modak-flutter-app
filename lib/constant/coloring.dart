// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

class Coloring {
  /// main 색깔
  static const Gradient main = LinearGradient(
      begin: FractionalOffset(-0.25, -0.25),
      end: FractionalOffset(1, 1),
      colors: [Color(0xFFFFB1B3), Color(0xFFFACCA1)]);

  /// sub 색깔
  static const Gradient sub_purple = LinearGradient(
      begin: FractionalOffset(-0.25, -0.25),
      end: FractionalOffset(1, 1),
      colors: [Color(0xFFEEA4CE), Color(0xFFC58BF2)]);

  static const Gradient sub_blue = LinearGradient(
      begin: FractionalOffset(0, 0.7),
      end: FractionalOffset(1, 0.1),
      colors: [Color(0xFF6BCAFF), Color(0xFF85BDFF)]);

  /// notice 색깔
  static const Gradient notice = LinearGradient(
      begin: FractionalOffset(-0.7, -0.7),
      end: FractionalOffset(2.5, 1.2),
      colors: [Color(0xFFBBDDFF), Color(0xFFEDCDFF)]);

  /// 회색 색깔
  static const Color gray_0 = Color(0xFF403739);
  static const Color gray_10 = Color(0xFF7B6F72);
  static const Color gray_20 = Color(0xFFADA4A5);
  static const Color gray_30 = Color(0xFFDDDADA);
  static const Color gray_40 = Color(0xFFF2F2F2);
  static const Color gray_50 = Color(0xFFF7F8F8);

  /// info 색깔
  static const Color info_success = Color(0XFF42D742);
  static const Color info_warning = Color(0XFFFF0000);
  // TODO 나중에 info 역할 추가
  static const Color info_yellow = Color(0XFFFFD600);
  static const Color info_blue = Color(0XFF6333EC);
  static const Color info_pink = Color(0XFFFF69B1);

  /// point 색깔
  static const Color point_orange = Color(0XFFFF7A00);
  static const Color point_pureorange = Color(0XFFFFBE99);

  /// background 색깔
  static const Color bg_red = Color(0XFFFFD0D5);
  static const Color bg_orange = Color(0XFFFFDFD0);
  static const Color bg_yellow = Color(0XFFFFF4B8);
  static const Color bg_green = Color(0XFFB4F5F2);
  static const Color bg_blue = Color(0XFFC9E6FF);
  static const Color bg_purple = Color(0XFFE0D4FF);
  static const Color bg_pink = Color(0XFFFFD8F6);

  /// todo memo 색깔
  static const Color todo_red = Color(0XFFFFCACA);
  static const Color todo_orange = Color(0XFFFFE4D0);
  static const Color todo_yellow = Color(0XFFFFF4B8);
  static const Color todo_lightgreen = Color(0XFFD3ECBB);
  static const Color todo_green = Color(0XFFAFE0D4);
  static const Color todo_blue = Color(0XFFC9E6FF);
  static const Color todo_pink = Color(0XFFFFE7F7);
  static const Color todo_purple = Color(0XFFDFD5FF);
}
