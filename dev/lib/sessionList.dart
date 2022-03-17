import 'dart:html';

import 'package:animations/animations.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:climbjio/colors.dart';
import 'package:climbjio/components/show_snackbar.dart';
import 'package:climbjio/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SessionList extends StatefulWidget {
  const SessionList({Key? key}) : super(key: key);

  @override
  State<SessionList> createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  late List<Session> _sessions = <Session>[];
  late List<Session> _oldSessions = <Session>[];
  final _joinName = TextEditingController();

  void fetchSession() {
    apiGetSession().then((value) {
      setState(() {
        _sessions = value;
        _sessions.sort();
        _oldSessions = getOldSessions(_sessions);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSession();
  }

  List<Session> getOldSessions(sessions) {
    List<Session> old = [];
    var now = DateTime.now();
    var yester = DateTime(now.year, now.month, now.day - 1);
    for (var s in _sessions) {
      var day = s.date.split(" ")[0];
      if (DateTime.parse(day).isBefore(yester)) {
        old.add(s);
      }
    }
    return old;
  }

  void updateClimbersForSession(String id, String name) {
    if (name.isNotEmpty) {
      _joinName.clear();
      apiUpdateClimbers(id, name).then((value) {
        if (value.statusCode == 200) {
          fetchSession();
        }
      });
    }
  }

  void copySessions() {
    String toCopy = "";
    for (var s in _sessions) {
      toCopy = toCopy + s.toPrettyString() + "\n";
    }
    Clipboard.setData(ClipboardData(text: toCopy));
    if (_sessions.isNotEmpty) {
      showSnackbar(context: context, message: 'Copied.');
    }
  }

  void archiveSessions() {
    var now = DateTime.now();
    var yester = DateTime(now.year, now.month, now.day - 1);
    var archived = [];
    for (var s in _sessions) {
      var day = s.date.split(" ")[0];
      if (DateTime.parse(day).isBefore(yester)) {
        apiArchiveSession(s);
        apiDeleteSession(s.id).then((value) => {fetchSession()});
        archived.add(s);
      }
    }
    if (archived.isNotEmpty) {
      var msg = 'Archived ' + archived.length.toString() + ' session(s).';
      showSnackbar(context: context, message: msg);
    } else {
      showSnackbar(context: context, message: 'No session to be archived.');
    }
  }

  void _deleteSession(String id) {
    apiDeleteSession(id).then((value) {
      if (value.statusCode == 200) {
        fetchSession();
      }
    });
  }

  void deleteSesssion(String id, String info) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Delete session?"),
            content: Text(info),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Nah",
                    style: TextStyle(color: kClimbjioBrown400),
                  )),
              TextButton(
                  onPressed: () {
                    _deleteSession(id);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "DELETE",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  )),
            ],
          );
        });
  }

  Widget getEditSessionForm() {
    return Container();
  }

  Widget getSessionCards() {
    if (_sessions.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Spacer(),
          Text("No upcoming sessions 😧"),
          Text("Create one in the  < Let 's Jio>  tab"),
          Spacer(),
          Spacer(),
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: ListView.builder(
        itemCount: _sessions.length,
        itemBuilder: (BuildContext context, int index) {
          Session s = _sessions[index];
          return ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 100, maxHeight: 100),
            child: GestureDetector(
              onLongPress: () {
                deleteSesssion(s.id, s.toPrettyString());
              },
              child: Card(
                elevation: 3,
                color: kClimbjioPink50,
                shadowColor: kClimbjioBrown400,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.calendarDay,
                                  size: 15,
                                  color: kClimbjioBrown900,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(s.date),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.clock,
                                  size: 15,
                                  color: kClimbjioBrown900,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(s.time1 +
                                    " : " +
                                    s.time2 +
                                    "  -  " +
                                    s.time3),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.locationArrow,
                                  size: 15,
                                  color: kClimbjioBrown900,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(s.gym),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          flex: 5,
                          child: SizedBox(
                            width: 300,
                            height: 150,
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              children: [
                                Text(s.name),
                              ],
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: OpenContainer(
                            closedColor: kClimbjioPink300,
                            closedBuilder: ((context, action) {
                              return IconButton(
                                onPressed: () {
                                  action();
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: kClimbjioBrown900,
                                ),
                              );
                            }),
                            openBuilder: (context, action) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 100, 30, 30),
                                child: Column(children: [
                                  const ListTile(
                                    title: Center(child: Text("Join Session")),
                                  ),
                                  Text(s.date,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  Text(
                                      s.time1 +
                                          " : " +
                                          s.time2 +
                                          "  -  " +
                                          s.time3,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  Text(s.gym,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  const SizedBox(height: 40),
                                  ListTile(
                                    title: TextField(
                                      // enabled: false,
                                      controller: _joinName,
                                      onTap: () {},
                                      decoration: InputDecoration(
                                          labelText: "who's joining?",
                                          labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          if (_joinName.text.isEmpty) {
                                            return;
                                          }
                                          updateClimbersForSession(s.id,
                                              s.name + ", " + _joinName.text);
                                          action();
                                        },
                                        icon: const FaIcon(
                                            FontAwesomeIcons.paperPlane)),
                                  ),
                                  const SizedBox(height: 60),
                                  IconButton(
                                    icon: const FaIcon(
                                        FontAwesomeIcons.windowClose),
                                    onPressed: () {
                                      action();
                                    },
                                  )
                                ]),
                              );
                            }),
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500, minWidth: 400),
            child: getSessionCards()),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
            onPressed: () {
              copySessions();
            },
            icon: const FaIcon(FontAwesomeIcons.copy)),
        const SizedBox(width: 30),
        Badge(
          showBadge: _oldSessions.isNotEmpty,
          position: const BadgePosition(top: 0.1),
          child: IconButton(
              onPressed: () {
                archiveSessions();
              },
              icon: const Icon(Icons.archive_outlined)),
        )
      ]),
    );
  }
}
