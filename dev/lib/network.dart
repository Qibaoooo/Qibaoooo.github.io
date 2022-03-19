// {"-My6Zz6NGCwCItAxuZAa":{"date":"2022-03-17 THU","gym":"BM_TaiSeng","name":"qibao","time_1":"11","time_2":"30","time_3":"AM"}}
import 'dart:convert';

import 'package:climbjio/components/auth/user_manager.dart';
import 'package:climbjio/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Session implements Comparable<Session> {
  late String date;
  late String gym;
  late String name;
  late String time1;
  late String time2;
  late String time3;
  late String id;

  @override
  int compareTo(Session other) {
    var selfDay = DateTime.parse(date.split(" ")[0]);
    var otherDay = DateTime.parse(other.date.split(" ")[0]);
    if (selfDay.isAfter(otherDay)) {
      return 1;
    }
    if (selfDay.isBefore(otherDay)) {
      return -1;
    }
    if ((time3 == 'AM') && (other.time3 == "PM")) {
      return -1;
    }
    if ((time3 == 'PM') && (other.time3 == "AM")) {
      return 1;
    }
    if (num.tryParse(time1)! < num.tryParse(other.time1)!) {
      return -1;
    }
    if (int.tryParse(time1)! > int.tryParse(other.time1)!) {
      return 1;
    }
    return 0;
  }

  Session(
      {required this.date,
      required this.gym,
      required this.name,
      required this.time1,
      required this.time2,
      required this.time3});

  Session.fromJson(Map json) {
    date = json["date"];
    gym = json["gym"];
    name = json["name"];
    time1 = json["time_1"];
    time2 = json["time_2"];
    time3 = json["time_3"];
  }

  List<String> nameList() {
    if (name.isEmpty) {
      return ['whoami?'];
    }
    var res = <String>[];
    for (var n in RegExp("[^,，]+").allMatches(name)) {
      res.add(n.group(0).toString());
    }
    return res;
  }

  Map toMap() {
    return {
      "date": date,
      "gym": gym,
      "name": name,
      "time_1": time1,
      "time_2": time2,
      "time_3": time3
    };
  }

  String toPrettyString() {
    return "• " +
        date +
        " / " +
        time1 +
        ":" +
        time2 +
        " - " +
        time3 +
        " / " +
        gym +
        " / " +
        name;
  }
}

Future<http.Response> apiCreateSession(Session sess) {
  Future<http.Response> resp;
  const _url =
      "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/sessions.json";
  String _postData = jsonEncode(sess.toMap());
  resp = http.post(Uri.parse(_url), body: _postData);
  return resp;
}

Future<http.Response> apiArchiveSession(Session sess) {
  Future<http.Response> resp;
  const _url =
      "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/archive.json";
  String _postData = jsonEncode(sess.toPrettyString());
  resp = http.post(Uri.parse(_url), body: _postData);
  return resp;
}

Future<http.Response> apiUpdateClimbers(String id, String name) {
  Future<http.Response> resp;
  var _url =
      "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/sessions/" +
          id +
          ".json";
  String _postData = jsonEncode({"name": name});
  resp = http.patch(Uri.parse(_url), body: _postData);
  return resp;
}

Future<List<Session>> apiGetSession() async {
  List<Session> results = <Session>[];
  const _url =
      "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/sessions.json";
  var resp = await http.get(Uri.parse(_url));
  var parsed = jsonDecode(resp.body);
  for (var key in parsed.keys) {
    Session s = Session.fromJson(parsed[key]);
    s.id = key;
    results.add(s);
  }
  return results;
}

Future<http.Response> apiDeleteSession(String id) {
  Future<http.Response> resp;
  var _url =
      "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/sessions/" +
          id +
          ".json";
  resp = http.delete(Uri.parse(_url));
  return resp;
}

Future<List> apiGetArchivedSession() async {
  List results = [];
  const _url =
      "https://climbjio-default-rtdb.asia-southeast1.firebasedatabase.app/archive.json";
  var resp = await http.get(Uri.parse(_url));
  var parsed = jsonDecode(resp.body);
  for (var key in parsed.keys) {
    results.add(parsed[key].toString());
  }
  return results;
}

Future<void> loginAsVisitor() async {
  UserCredential userCredential =
      await FirebaseAuth.instance.signInAnonymously();
  print(userCredential.user);
}

Future<void> logout() async {
  userManager.clearSessionData();
  await FirebaseAuth.instance.signOut();
}

Future<void> loginWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn(clientId: clintIdGoogleSignin).signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // print(credential.accessToken); this one is empty
  // print(credential.idToken);

  // Once signed in
  if (googleUser != null && googleAuth != null) {
    userManager.firebaseCredential = await signInToFireBase(credential);
    await userManager.loadFromData(googleUser, credential);
  }
}

Future<UserCredential> signInToFireBase(OAuthCredential credential) async {
  // TODO: handle failure cases
  UserCredential fireCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  return fireCredential;
}
