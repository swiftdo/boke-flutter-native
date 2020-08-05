import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4465026491979447~1027194024";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4465026491979447~5923355536";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4465026491979447/9562507204";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4465026491979447/4503296807";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4465026491979447/6936343864";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4465026491979447/6937888452";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4465026491979447/4118608836";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4465026491979447/9180908414";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4465026491979447/5022171557";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4465026491979447/2282782987";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
