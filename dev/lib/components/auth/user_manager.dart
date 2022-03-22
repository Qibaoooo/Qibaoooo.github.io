// ignore_for_file: unnecessary_this, constant_identifier_names, import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'dart:developer';

import 'package:climbjio/network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

const UM_displayName = 'UM_displayName';
const UM_nickName = 'UM_nickName';
const UM_email = 'UM_email';
const UM_id = 'UM_id';
const UM_photoUrl = 'UM_photoUrl';
const UM_idToken = 'UM_idToken';

class UserManager with ChangeNotifier {
  // created by me
  late bool isLoggedin;

  late String nickName;
  late String displayName;
  late String email;
  late String id;
  late String photoUrl;
  late String idToken;
  late OAuthCredential? oAuthCredential;
  late UserCredential? firebaseCredential;

  UserManager() {
    this.nickName = "climber";
    this.isLoggedin = false;
  }

  Future<void> saveToLocalPrefs(String UM_key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(UM_key, value);
  }

  Future<String?> loadFromLocalPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? displayName = prefs.getString(UM_displayName);
    String? nickName = prefs.getString(UM_nickName);
    String? email = prefs.getString(UM_email);
    String? id = prefs.getString(UM_id);
    String? photoUrl = prefs.getString(UM_photoUrl);
    String? idToken = prefs.getString(UM_idToken);
    if (displayName != null &&
        email != null &&
        id != null &&
        photoUrl != null &&
        idToken != null &&
        nickName != null) {
      this.displayName = displayName;
      this.email = email;
      this.id = id;
      this.photoUrl = photoUrl;
      this.idToken = idToken;

      this.nickName = nickName; // to be changed
      notifyListeners();

      // not just load token, verify can login as well.
      try {
        print('signing to firebase using saved session token...');
        firebaseCredential = await signInToFireBase(
            GoogleAuthProvider.credential(idToken: idToken));
      } catch (err) {
        log(err.toString());
        log('Seems like your last seesion has ended. Please login again.');
        await clearSessionData();
        return null;
      }

      this.isLoggedin = true;
      return idToken;
    }
    return null;
  }

  // load user date from google sign in return
  // and save it as local session
  Future<void> loadFromData(
      GoogleSignInAccount user, OAuthCredential oAuthCredential) async {
    this.displayName = user.displayName!;
    this.email = user.email!;
    this.id = user.id;
    this.photoUrl = user.photoUrl;
    this.oAuthCredential = oAuthCredential;
    this.idToken = oAuthCredential.idToken!;

    var remoteNickName = await apiGetRemoteUserNickName();
    if (remoteNickName.isNotEmpty) {
      this.nickName = remoteNickName;
      this.isLoggedin = true;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(UM_displayName, this.displayName);
    await prefs.setString(UM_nickName, this.nickName);
    await prefs.setString(UM_email, this.email);
    await prefs.setString(UM_id, this.id);
    await prefs.setString(UM_photoUrl, this.photoUrl);
    await prefs.setString(UM_idToken, this.oAuthCredential!.idToken!);
  }

  Future<void> clearSessionData() async {
    this.nickName = 'climber';
    this.displayName = '';
    this.email = '';
    this.id = '';
    this.photoUrl = '';
    this.idToken = '';
    this.oAuthCredential = null;
    this.firebaseCredential = null;

    this.isLoggedin = false;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(UM_displayName);
    prefs.remove(UM_nickName);
    prefs.remove(UM_email);
    prefs.remove(UM_id);
    prefs.remove(UM_photoUrl);
    prefs.remove(UM_idToken);

    isLoggedInNotifier.value = false;
  }
}
