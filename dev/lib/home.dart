import 'package:climbjio/homeDrawer.dart';
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
          drawer: homeDrawer(),
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
            title: const Center(child: Text('ClimbJio')),
            bottom: const TabBar(
              labelColor: kClimbjioBrown900,
              tabs: [
                Tab(text: ('Show Sessions')),
                Tab(text: ('Let\'s Jio')),
              ],
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const FaIcon(FontAwesomeIcons.user),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
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
