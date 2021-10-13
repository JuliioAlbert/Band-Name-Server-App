import 'package:app_scaffold/ui/pages/Home/home_page.dart';
import 'package:app_scaffold/ui/pages/Status/status.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "home": (_) => HomePage(),
  "status": (_) => StatusPage(),
};
