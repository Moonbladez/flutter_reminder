// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDkkSQImpbHrgcIaZiqooQRAIViwi4I1cQ',
    appId: '1:521130274957:web:1c79346ba9b430b2ecb2c4',
    messagingSenderId: '521130274957',
    projectId: 'bulu-flutter-reminders',
    authDomain: 'bulu-flutter-reminders.firebaseapp.com',
    storageBucket: 'bulu-flutter-reminders.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnLbIQHDZeG4gxvw-qeoin4ipuU09QApc',
    appId: '1:521130274957:android:99d07a847efec5cfecb2c4',
    messagingSenderId: '521130274957',
    projectId: 'bulu-flutter-reminders',
    storageBucket: 'bulu-flutter-reminders.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpdE5-k7N4BDGkqxnCW1Mqi98t4DztAJ8',
    appId: '1:521130274957:ios:ff64f3406ce44e3becb2c4',
    messagingSenderId: '521130274957',
    projectId: 'bulu-flutter-reminders',
    storageBucket: 'bulu-flutter-reminders.appspot.com',
    iosClientId:
        '521130274957-i2h7okch3pj6a32k2v3jl6u0va77cki7.apps.googleusercontent.com',
    iosBundleId: 'com.example.reminders',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBpdE5-k7N4BDGkqxnCW1Mqi98t4DztAJ8',
    appId: '1:521130274957:ios:ff64f3406ce44e3becb2c4',
    messagingSenderId: '521130274957',
    projectId: 'bulu-flutter-reminders',
    storageBucket: 'bulu-flutter-reminders.appspot.com',
    iosClientId:
        '521130274957-i2h7okch3pj6a32k2v3jl6u0va77cki7.apps.googleusercontent.com',
    iosBundleId: 'com.example.reminders',
  );
}
