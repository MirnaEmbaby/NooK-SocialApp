import 'package:flutter/material.dart';

const Color myIndigo = Color(0xFF3A2CC7);

const int _myIndigoPrimaryValue = 0xFF3A2CC7;
const MaterialColor myIndigoMaterial = MaterialColor(
  _myIndigoPrimaryValue,
  <int, Color>{
    50: Color(0xFFE5E3F6),
    100: Color(0xFFBDB8E9),
    200: Color(0xFF928ADC),
    300: Color(0xFF665BCC),
    400: Color(0xFF463CC1),
    500: Color(_myIndigoPrimaryValue),
    600: Color(0xFF3428BF),
    700: Color(0xFF2D22B5),
    800: Color(0xFF261CAC),
    900: Color(0xFF1A129B),
  },
);

const Color fadedBlack = Color(0xFF090909);
