import 'dart:async';
import 'dart:ui';

import 'package:ecommerce_app/src/app.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* turn off the '#' in the URLs on the web
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  //* Error handler
  registerErrorHandlers();
  // * Entry point of the app
  runApp(const ProviderScope(child: MyApp()));

  // // * For more info on error handling, see:
  // // * https://docs.flutter.dev/testing/errors
  // await runZonedGuarded(() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   // turn off the # in the URLs on the web
  //   GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  //   registerErrorHandlers();
  //   // * Entry point of the app
  //   runApp(const MyApp());

  //   // * This code will present some error UI if any uncaught exception happens
  //   FlutterError.onError = (FlutterErrorDetails details) {
  //     FlutterError.presentError(details);
  //   };
  //   ErrorWidget.builder = (FlutterErrorDetails details) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: Colors.red,
  //         title: Text('An error occurred'.hardcoded),
  //       ),
  //       body: Center(child: Text(details.toString())),
  //     );
  //   };
  // }, (Object error, StackTrace stack) {
  //   // * Log any errors to console
  //   debugPrint(error.toString());
  // });
}

void registerErrorHandlers() {
  //* shows some error UI if anyuncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };

  //* Handle errors from underlying platforms IOS/Andorid

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };

  //* Show some UI error when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
