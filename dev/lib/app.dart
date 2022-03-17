import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home.dart';
import 'sessionForm.dart';
import 'colors.dart';

class ClimbjioApp extends StatelessWidget {
  const ClimbjioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;
    return MaterialApp(
      title: 'ClimbJio',
      home: const HomePage(),
      theme: _kClimbjioTheme,
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => const SessionForm(),
      fullscreenDialog: true,
    );
  }
}

final ThemeData _kClimbjioTheme = _buildClimbjioTheme();

ThemeData _buildClimbjioTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kClimbjioPink100,
      onPrimary: kClimbjioBrown900,
      secondary: kClimbjioBrown400,
      error: kClimbjioErrorRed,
    ),
    textTheme: _buildClimbjioTextTheme(base.textTheme),
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: kClimbjioPink100),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: kClimbjioBrown900,
        ),
      ),
      border: UnderlineInputBorder(),
    ),
  );
}

TextTheme _buildClimbjioTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kClimbjioBrown900,
        bodyColor: kClimbjioBrown900,
      );
}
