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
    apiKey: 'AIzaSyBqrM9b2g1eBSmq2MeKWlexvV_DLG86Iv8',
    appId: '1:254366693159:web:a635217806a57bedea1b02',
    messagingSenderId: '254366693159',
    projectId: 'my-first-project-d57f6',
    authDomain: 'my-first-project-d57f6.firebaseapp.com',
    storageBucket: 'my-first-project-d57f6.appspot.com',
    measurementId: 'G-XRJ7H8CV6E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjSvF2JkhgaNhp3-sO6R7dCElZL5RkjP4',
    appId: '1:254366693159:android:a4308836f6fb17cfea1b02',
    messagingSenderId: '254366693159',
    projectId: 'my-first-project-d57f6',
    storageBucket: 'my-first-project-d57f6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZn8pTYzTxM3swyYELilDvgtyHnxCKZTQ',
    appId: '1:254366693159:ios:632ec2ce946c1bacea1b02',
    messagingSenderId: '254366693159',
    projectId: 'my-first-project-d57f6',
    storageBucket: 'my-first-project-d57f6.appspot.com',
    iosBundleId: 'com.example.cloneWhatsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZn8pTYzTxM3swyYELilDvgtyHnxCKZTQ',
    appId: '1:254366693159:ios:d2c199aeea47253cea1b02',
    messagingSenderId: '254366693159',
    projectId: 'my-first-project-d57f6',
    storageBucket: 'my-first-project-d57f6.appspot.com',
    iosBundleId: 'com.example.cloneWhatsapp.RunnerTests',
  );
}