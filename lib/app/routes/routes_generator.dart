import 'package:flutter/material.dart';
import 'package:morphing/app/pages/home/ui/home_ui.dart';
import 'package:morphing/shared/analytics.dart';
import 'package:morphing/shared/locator.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    locator<AnalyticsService>().sendPageAnalytics(settings.name);
    // final Map<String, dynamic> args =
    //     settings.arguments as Map<String, dynamic>;

    switch (settings.name) {
      case Routes.index:
        return MaterialPageRoute<dynamic>(builder: (_) => HomeUI());

      default:
        return _route404();
    }
  }

  static Route<dynamic> _route404() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('404'),
        ),
        body: const Center(
          child: Text('Page Not Found'),
        ),
      );
    });
  }
}
