// ignore_for_file: unnecessary_this

import 'package:firebase_auth/firebase_auth.dart';

class UserManager {
  // created by me
  late String nickName;

  // get from firebase
  late UserCredential userCredential;

  UserManager() {
    this.nickName = "climber";
  }
}
