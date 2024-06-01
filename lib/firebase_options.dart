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
    apiKey: 'AIzaSyDa7YdteGVuaTfgmOPDYJsinclTsscp0F8',
    appId: '1:543075645079:web:e6da77ef3bf78f23f31bd2',
    messagingSenderId: '543075645079',
    projectId: 'testmumbai-b8f4c',
    authDomain: 'testmumbai-b8f4c.firebaseapp.com',
    storageBucket: 'testmumbai-b8f4c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbspZV2ypqDehvulF3B_4XAuReNGP_Qng',
    appId: '1:543075645079:android:844aaefb1ed4d84df31bd2',
    messagingSenderId: '543075645079',
    projectId: 'testmumbai-b8f4c',
    storageBucket: 'testmumbai-b8f4c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMFOKMFO1xWruDNrh2vwqGLJqQljKf7FU',
    appId: '1:543075645079:ios:3fc1f3c7f868ef2cf31bd2',
    messagingSenderId: '543075645079',
    projectId: 'testmumbai-b8f4c',
    storageBucket: 'testmumbai-b8f4c.appspot.com',
    iosBundleId: 'com.example.mumbaiMachinetask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDMFOKMFO1xWruDNrh2vwqGLJqQljKf7FU',
    appId: '1:543075645079:ios:3fc1f3c7f868ef2cf31bd2',
    messagingSenderId: '543075645079',
    projectId: 'testmumbai-b8f4c',
    storageBucket: 'testmumbai-b8f4c.appspot.com',
    iosBundleId: 'com.example.mumbaiMachinetask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDa7YdteGVuaTfgmOPDYJsinclTsscp0F8',
    appId: '1:543075645079:web:f3b1bbed4c361b6ef31bd2',
    messagingSenderId: '543075645079',
    projectId: 'testmumbai-b8f4c',
    authDomain: 'testmumbai-b8f4c.firebaseapp.com',
    storageBucket: 'testmumbai-b8f4c.appspot.com',
  );
}
