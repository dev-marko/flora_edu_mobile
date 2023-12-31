// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flora_edu_mobile/shared/constants/environment.dart';
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
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static FirebaseOptions android = FirebaseOptions(
    apiKey: Environment.firebaseAndroidApiKey,
    appId: '1:808218864114:android:9c288d9a9dca89d29fa36b',
    messagingSenderId: '808218864114',
    projectId: 'flora-edu-mobile',
    databaseURL: 'https://flora-edu-mobile-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flora-edu-mobile.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: Environment.firebaseiOSApiKey,
    appId: '1:808218864114:ios:afdb39c594d74c199fa36b',
    messagingSenderId: '808218864114',
    projectId: 'flora-edu-mobile',
    databaseURL: 'https://flora-edu-mobile-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flora-edu-mobile.appspot.com',
    iosClientId: '808218864114-2s5v16rki6v2k4fq62coujk0j9mvk049.apps.googleusercontent.com',
    iosBundleId: 'com.example.floraEduMobile',
  );
}
