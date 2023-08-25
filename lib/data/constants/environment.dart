import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }

    return '.env.development';
  }

  static String get firebaseAndroidApiKey {
    return dotenv.get('FIREBASE_ANDROID_API_KEY',
        fallback: 'Firebase Android API key not found.');
  }

  static String get firebaseiOSApiKey {
    return dotenv.get('FIREBASE_IOS_API_KEY',
        fallback: 'Firebase iOS API key not found.');
  }
}
