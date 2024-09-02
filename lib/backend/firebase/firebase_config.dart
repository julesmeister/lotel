import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBgbq-i69JeAf8iOckgrtSRyxVec5pu1xw",
            authDomain: "leehotels.firebaseapp.com",
            projectId: "leehotels",
            storageBucket: "leehotels.appspot.com",
            messagingSenderId: "405064043770",
            appId: "1:405064043770:web:228ae0c50843a89b8e0d43",
            measurementId: "G-GTZ1LXYRZ0"));
  } else {
    await Firebase.initializeApp();
  }
}
