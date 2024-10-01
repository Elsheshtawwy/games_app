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
    apiKey: 'AIzaSyD4GL-nApNE_fo44Y9h1dQVvwEwObpn-8A',
    appId: '1:37217885985:web:b674229eed3380a4be6860',
    messagingSenderId: '37217885985',
    projectId: 'gamesway-2ca32',
    authDomain: 'gamesway-2ca32.firebaseapp.com',
    storageBucket: 'gamesway-2ca32.appspot.com',
    measurementId: 'G-CC3TFSMSDL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDBp6S37TtxLvK7iC06QrH-8Q78aqs7Ew',
    appId: '1:37217885985:android:b927538e182e1a49be6860',
    messagingSenderId: '37217885985',
    projectId: 'gamesway-2ca32',
    storageBucket: 'gamesway-2ca32.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZPZMPIBN6LpRkjOlgCPbmRgAaG_MjB74',
    appId: '1:37217885985:ios:da81ebf00d5b54f8be6860',
    messagingSenderId: '37217885985',
    projectId: 'gamesway-2ca32',
    storageBucket: 'gamesway-2ca32.appspot.com',
    iosBundleId: 'com.example.gamesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZPZMPIBN6LpRkjOlgCPbmRgAaG_MjB74',
    appId: '1:37217885985:ios:da81ebf00d5b54f8be6860',
    messagingSenderId: '37217885985',
    projectId: 'gamesway-2ca32',
    storageBucket: 'gamesway-2ca32.appspot.com',
    iosBundleId: 'com.example.gamesApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD4GL-nApNE_fo44Y9h1dQVvwEwObpn-8A',
    appId: '1:37217885985:web:f41edf0b86b1aec9be6860',
    messagingSenderId: '37217885985',
    projectId: 'gamesway-2ca32',
    authDomain: 'gamesway-2ca32.firebaseapp.com',
    storageBucket: 'gamesway-2ca32.appspot.com',
    measurementId: 'G-8X3RYQT52D',
  );
}
