import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAph00tODkWbk307OOTeyeW2QaBoUh9b-Y",
            authDomain: "envision-8wd5is.firebaseapp.com",
            projectId: "envision-8wd5is",
            storageBucket: "envision-8wd5is.firebasestorage.app",
            messagingSenderId: "989290980604",
            appId: "1:989290980604:web:9ea4ca0a6ebeee79306379"));
  } else {
    await Firebase.initializeApp();
  }
}
