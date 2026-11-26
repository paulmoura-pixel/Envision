// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> obPickAndUploadPhoto(String slot) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return '';
  final x = await ImagePicker()
      .pickImage(source: ImageSource.gallery, maxWidth: 1600, imageQuality: 85);
  if (x == null) return '';
  final path = slot == 'profile'
      ? 'profile_photos/$uid/avatar.jpg'
      : 'progress_photos/$uid/$slot.jpg';
  await FirebaseStorage.instance.ref(path).putData(
      await x.readAsBytes(), SettableMetadata(contentType: 'image/jpeg'));
  FFAppState().update(() {
    switch (slot) {
      case 'front':
        FFAppState().obPhotoFront = path;
        break;
      case 'side':
        FFAppState().obPhotoSide = path;
        break;
      case 'back':
        FFAppState().obPhotoBack = path;
        break;
      default:
        FFAppState().obProfilePhotoPath = path;
    }
  });
  return path;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
