import 'package:climbjio/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:climbjio/colors.dart';
import 'package:climbjio/sessionForm.dart';
import 'package:climbjio/sessionList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('hi,'),
                userProfileEntry(),
              ],
            ),
            bottom: const TabBar(
              labelColor: kClimbjioBrown900,
              tabs: [
                Tab(text: ('Show Sessions')),
                Tab(text: ('Let\'s Jio')),
              ],
            ),
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
