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
    apiKey: 'AIzaSyBRAqBMq0emPf0FF7GhZ6mfiiLywFOf7Y8',
    appId: '1:253315326017:web:d8ab234bd8fcce3f5426c0',
    messagingSenderId: '253315326017',
    projectId: 'login',
    authDomain: 'login.firebaseapp.com',
    storageBucket: 'login.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSOGeUM6XTpzd7eYxOEXou1BM9_X5Ve_c',
    appId: '1:253315326017:android:df9ced7e94ac46915426c0',
    messagingSenderId: '253315326017',
    projectId: 'login',
    storageBucket: 'login.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUmxRO4naJ9C0GWU4YWMHajNkI6GTWZWs',
    appId: '1:253315326017:ios:432f68f6e81d25ae5426c0',
    messagingSenderId: '253315326017',
    projectId: 'login',
    storageBucket: 'login.appspot.com',
    iosClientId: '253315326017-8qfcvrc1l2u2fmcdug1rjlm36lqes6ff.apps.googleusercontent.com',
    iosBundleId: 'com.example.evcilPati',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUmxRO4naJ9C0GWU4YWMHajNkI6GTWZWs',
    appId: '1:253315326017:ios:2b272f7e07c11f085426c0',
    messagingSenderId: '253315326017',
    projectId: 'login',
    storageBucket: 'login.appspot.com',
    iosClientId: '253315326017-57899anopusn1cegaptcikn2t45nrcpm.apps.googleusercontent.com',
    iosBundleId: 'com.example.evcilPati.RunnerTests',
  );
}
