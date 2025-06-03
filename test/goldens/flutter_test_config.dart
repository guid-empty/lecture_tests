import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig.current().copyWith(
      goldenTestTheme: GoldenTestTheme.standard()
          .copyWith(backgroundColor: Colors.white) as GoldenTestTheme?,

      /// platformGoldensConfig для CI...
    ),
    run: testMain,
  );
}
