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
    apiKey: 'AIzaSyDIXc9zXTcYzQ30SrA1KVkChKXIC-mwZPk',
    appId: '1:268003243929:web:59b636ede416d994924508',
    messagingSenderId: '268003243929',
    projectId: 'seedsrestaurant-330fd',
    authDomain: 'seedsrestaurant-330fd.firebaseapp.com',
    storageBucket: 'seedsrestaurant-330fd.appspot.com',
    measurementId: 'G-RKCQLM7SYH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCn2MheEhcDQkMa0w6DEz2Ifs88dqAukFU',
    appId: '1:268003243929:android:a879492263491431924508',
    messagingSenderId: '268003243929',
    projectId: 'seedsrestaurant-330fd',
    storageBucket: 'seedsrestaurant-330fd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmjglmrhQ2MAFFlDRoQM6RXoL_yuNHbqE',
    appId: '1:268003243929:ios:828a6b6d4486b68f924508',
    messagingSenderId: '268003243929',
    projectId: 'seedsrestaurant-330fd',
    storageBucket: 'seedsrestaurant-330fd.appspot.com',
    iosClientId: '268003243929-inuofveijj3kjaf8ag5mudqm5llqj1p2.apps.googleusercontent.com',
    iosBundleId: 'com.example.seedsAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmjglmrhQ2MAFFlDRoQM6RXoL_yuNHbqE',
    appId: '1:268003243929:ios:828a6b6d4486b68f924508',
    messagingSenderId: '268003243929',
    projectId: 'seedsrestaurant-330fd',
    storageBucket: 'seedsrestaurant-330fd.appspot.com',
    iosClientId: '268003243929-inuofveijj3kjaf8ag5mudqm5llqj1p2.apps.googleusercontent.com',
    iosBundleId: 'com.example.seedsAdmin',
  );
}