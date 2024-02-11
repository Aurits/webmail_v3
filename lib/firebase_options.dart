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
    apiKey: 'AIzaSyB3t0JhPJbciFvw4ct7lLxgazkGmS7TSL0',
    appId: '1:430314973310:web:ea216bbb2bf76e4c67902f',
    messagingSenderId: '430314973310',
    projectId: 'webmail-2da62',
    authDomain: 'webmail-2da62.firebaseapp.com',
    storageBucket: 'webmail-2da62.appspot.com',
    measurementId: 'G-3Z63GCG39T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYN1Pc0w2UfDze4v2csZ6nCnv8ShH8adI',
    appId: '1:430314973310:android:3e600144dc8f529e67902f',
    messagingSenderId: '430314973310',
    projectId: 'webmail-2da62',
    storageBucket: 'webmail-2da62.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4SSRUReQXBbjZFrg7a1Ekyx5UNnByMKE',
    appId: '1:430314973310:ios:f289580b3c45008567902f',
    messagingSenderId: '430314973310',
    projectId: 'webmail-2da62',
    storageBucket: 'webmail-2da62.appspot.com',
    androidClientId: '430314973310-jdfm22qbg6scti4u2ai6qofmnhmksl4n.apps.googleusercontent.com',
    iosBundleId: 'com.example.webmail',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4SSRUReQXBbjZFrg7a1Ekyx5UNnByMKE',
    appId: '1:430314973310:ios:d7b3f93b853e2d2b67902f',
    messagingSenderId: '430314973310',
    projectId: 'webmail-2da62',
    storageBucket: 'webmail-2da62.appspot.com',
    androidClientId: '430314973310-jdfm22qbg6scti4u2ai6qofmnhmksl4n.apps.googleusercontent.com',
    iosBundleId: 'com.example.webmail.RunnerTests',
  );
}