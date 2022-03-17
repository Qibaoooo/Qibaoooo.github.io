// ignore_for_file: unnecessary_this

import 'package:firebase_auth/firebase_auth.dart';

class UserManager {
  // created by me
  late String nickName;
  late bool isLoggedin;

  // get from firebase
  late UserCredential userCredential;

  UserManager() {
    this.nickName = "climber";
    this.isLoggedin = false;
  }

  void loadFromData(UserCredential data) {
    var newNickName = data.user!.displayName!;
    if (newNickName.isNotEmpty) {
      this.nickName = newNickName;
      this.isLoggedin = true;
    }
  }
}
