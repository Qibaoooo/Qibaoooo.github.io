import 'package:climbjio/components/auth/user_manager.dart';
import 'package:climbjio/globals.dart';
import 'package:climbjio/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:climbjio/colors.dart';
import 'package:climbjio/sessionForm.dart';
import 'package:climbjio/sessionList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
            title: Center(child: Text('hi, ' + userManager.nickName)),
            bottom: const TabBar(
              labelColor: kClimbjioBrown900,
              tabs: [
                Tab(text: ('Show Sessions')),
                Tab(text: ('Let\'s Jio')),
              ],
            ),
            leading: userProfile(context),
          ),
          body: const TabBarView(children: [
            SessionList(),
            SessionForm(),
          ]),
        );
      }),
    );
  }
}
