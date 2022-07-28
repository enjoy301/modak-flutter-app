// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Coloring {
  /// main 색깔
  static final Gradient main = LinearGradient(
      begin: FractionalOffset(-0.25, -0.25),
      end: FractionalOffset(1, 1),
      colors: [Color(0xFFFFB1B3), Color(0xFFFACCA1)]);

  /// sub 색깔
  static final Gradient sub_purple = LinearGradient(
      begin: FractionalOffset(-0.25, -0.25),
      end: FractionalOffset(1, 1),
      colors: [Color(0xFFEEA4CE), Color(0xFFC58BF2)]);


  static final Gradient sub_blue = LinearGradient(
      begin: FractionalOffset(0, 0.7),
      end: FractionalOffset(1, 0.1),
      colors: [Color(0xFF6BCAFF), Color(0xFF85BDFF)]);

  /// notice 색깔
  static final Gradient notice = LinearGradient(
    begin: FractionalOffset(-0.7,-0.7),
      end: FractionalOffset(2.5,2.5),
      colors: [Color(0xFFBBDDFF), Color(0xFFEDCDFF)]);

  /// 회색 색깔
  static final Color gray_0 = Color(0xFF403739);
  static final Color gray_10 = Color(0xFF7B6F72);
  static final Color gray_20 = Color(0xFFADA4A5);
  static final Color gray_30 = Color(0xFFDDDADA);
  static final Color gray_40 = Color(0xFFF2F2F2);
  static final Color gray_50 = Color(0xFFF7F8F8);

  /// info 색깔
  static final Color info_success = Color(0XFF42D742);
  static final Color info_warning = Color(0XFFFF0000);
  // TODO 나중에 info 역할 추가
  static final Color info_yellow = Color(0XFFFFD600);
  static final Color info_blue = Color(0XFF6333EC);
  static final Color info_pink = Color(0XFFFF69B1);

  /// point 색깔
  static final Color point_orange = Color(0XFFFF7A00);
  static final Color point_pureorange = Color(0XFFFFBE99);

  /// background 색깔
  static final Color bg_red = Color(0XFFFFD0D5);
  static final Color bg_orange = Color(0XFFFFDFD0);
  static final Color bg_yellow = Color(0XFFFFF4B8);
  static final Color bg_green = Color(0XFFB4F5F2);
  static final Color bg_blue = Color(0XFFC9E6FF);
  static final Color bg_purple = Color(0XFFE0D4FF);
  static final Color bg_pink = Color(0XFFFFD8F6);
}
