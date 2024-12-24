// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAdkLcD6fCPXvnK0HZrE9SfCCSixFjN170',
    appId: '1:230990998393:web:2546cdf1478d2d556a1da8',
    messagingSenderId: '230990998393',
    projectId: 'simplechatapp01',
    authDomain: 'simplechatapp01.firebaseapp.com',
    storageBucket: 'simplechatapp01.firebasestorage.app',
    measurementId: 'G-FKSXNRY919',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwlXDfWsCEE7_ZcT-gbGnQD_pXjn_vSB8',
    appId: '1:230990998393:android:f9e31374f4ad1e236a1da8',
    messagingSenderId: '230990998393',
    projectId: 'simplechatapp01',
    storageBucket: 'simplechatapp01.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUQ0b1fgTZjN_sekHtWBEpWaYWvHgLXhU',
    appId: '1:230990998393:ios:5feb357477d6a1546a1da8',
    messagingSenderId: '230990998393',
    projectId: 'simplechatapp01',
    storageBucket: 'simplechatapp01.firebasestorage.app',
    iosBundleId: 'com.example.p1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUQ0b1fgTZjN_sekHtWBEpWaYWvHgLXhU',
    appId: '1:230990998393:ios:5feb357477d6a1546a1da8',
    messagingSenderId: '230990998393',
    projectId: 'simplechatapp01',
    storageBucket: 'simplechatapp01.firebasestorage.app',
    iosBundleId: 'com.example.p1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAdkLcD6fCPXvnK0HZrE9SfCCSixFjN170',
    appId: '1:230990998393:web:46daf31e4c55c4f46a1da8',
    messagingSenderId: '230990998393',
    projectId: 'simplechatapp01',
    authDomain: 'simplechatapp01.firebaseapp.com',
    storageBucket: 'simplechatapp01.firebasestorage.app',
    measurementId: 'G-ND51CGKQJD',
  );

}