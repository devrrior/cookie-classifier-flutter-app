import 'package:cookies_recognition_flutter_app/pages/cookie_photo_taker_page.dart';
import 'package:cookies_recognition_flutter_app/pages/home_page.dart';
import 'package:cookies_recognition_flutter_app/pages/result_classifier_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  "/": (context) => const HomePage(),
  "/cookie_photo_taker": (context) => const CookiePhotoTakerPage(),
};