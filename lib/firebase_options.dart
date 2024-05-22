// File generated by FlutterFire CLI.
import 'package:firebase_core/firebase_core.dart';
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      // throw UnsupportedError(
      //   'DefaultFirebaseOptions have not been configured for windows - '
      //   'you can reconfigure this by running the FlutterFire CLI again.',
      // );
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
    // apiKey: 'AIzaSyDPfqeoIFHeLqmKn8_cMDPKYMAmxz8wjHc',
    // appId: '1:1046369384630:web:8dc688fc2ce459d8608e17',
    // messagingSenderId: '1046369384630',
    // projectId: 'barera-store',
    // authDomain: 'barera-store.firebaseapp.com',
    // storageBucket: 'barera-store.appspot.com',
    // measurementId: 'G-Y1JN5NQX3R',
    apiKey: "AIzaSyCsUdGFLTjIElEorOvTL6GHaWls2ztR5V0",
    authDomain: "pindah-memilih.firebaseapp.com",
    projectId: "pindah-memilih",
    storageBucket: "pindah-memilih.appspot.com",
    messagingSenderId: "952522015049",
    appId: "1:952522015049:web:a5071eb2b66dcc8f979a98"
  );

//   const firebaseConfig = {
// };

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6iBYzs9hVSCwm_ceRgATEX3B2TC8eHeo',
    appId: '1:1046369384630:android:0d5de4b25c00e830608e17',
    messagingSenderId: '1046369384630',
    projectId: 'barera-store',
    storageBucket: 'barera-store.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    appId: '...',
    apiKey: '...',
    projectId: '...',
    messagingSenderId: '...',
    authDomain: '...',
  );
}
