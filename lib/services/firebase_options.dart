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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      // case TargetPlatform.macOS:
      //   return macos;
      // case TargetPlatform.windows:
      //   return windows;
      // case TargetPlatform.linux:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for linux - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB221jryfL17tl7w_1si3yvquZMJhNp14A',
    appId: '1:26012899022:android:c1bf650bd860b3dc83e29f',
    messagingSenderId: '26012899022',
    projectId: 'ace-gases',
    storageBucket: 'ace-gases.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHFWJIBp3KUWliKBKgkJbY8Icjpdkgsbo',
    appId: '1:26012899022:ios:9dea9732dfe33d3383e29f',
    messagingSenderId: '26012899022',
    projectId: 'ace-gases',
    storageBucket: 'ace-gases.appspot.com',
    iosBundleId: 'com.gis.acegaseshms',
  );
}
