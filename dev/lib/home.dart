import 'package:flutter/material.dart';
import 'package:shrine/colors.dart';
import 'package:shrine/sessionForm.dart';
import 'package:shrine/sessionList.dart';

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
          appBar: AppBar(
            title: const Center(child: Text('ClimbJio')),
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
