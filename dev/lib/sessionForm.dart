import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:intl/intl.dart';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shrine/colors.dart';
import 'package:shrine/network.dart';

final _gyms = <String>[
  "B+(JE)",
  "B+(Kallang)",
  "B8a",
  "BM(DownTown)",
  "BM(Rocher)",
  "BM(TaiSeng)",
  "CC(Funan)",
  "CC(Novena)",
  "CC(SportsHub)",
  "Kinetics",
  "OYEYO",
  "T-Hall",
];

class SessionForm extends StatefulWidget {
  const SessionForm({Key? key}) : super(key: key);

  @override
  _SessionFormState createState() => _SessionFormState();
}

class _SessionFormState extends State<SessionForm> {
  final _dateController = TextEditingController();
  final _climbersController = TextEditingController();
  String _climbers = "";
  String _selectedHour = "hour";
  String _selectedMin = "min";
  String _selectedAP = "AM/PM";
  String _selectedGym = "gym";
  bool _showPastSessionsButton = false;
  var pastSessions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiGetArchivedSession().then((value) {
      setState(() {
        pastSessions.addAll(value);
      });
    });
  }

  void resetState() {
    setState(() {
      _climbers = "";
      _selectedHour = "hour";
      _selectedMin = "min";
      _selectedAP = "AM/PM";
      _selectedGym = "gym";
      _dateController.text = "set date and time";
      _climbersController.text = "";
      FocusScope.of(context).unfocus();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        String day = picked.toString().split(" ")[0];
        String dayWeek = DateFormat("yyyy-MM-dd E").format(DateTime.parse(day));
        _dateController.text = dayWeek.toUpperCase();
      });
    }
  }

  Future<void> _selectHour(String v) async {
    setState(() {
      _selectedHour = v;
    });
  }

  Future<void> _selectMin(String v) async {
    setState(() {
      _selectedMin = v;
    });
  }

  Future<void> _selectAP(String v) async {
    setState(() {
      _selectedAP = v;
    });
  }

  Future<void> _selectGym(String v) async {
    setState(() {
      _selectedGym = v;
    });
  }

  Future<void> _setClimbers(String v) async {
    setState(() {
      _climbers = v;
    });
  }

  bool validateInput(String rowName) {
    switch (rowName) {
      case "DATETIME":
        if (DateTime.tryParse(_dateController.text.split(" ")[0]) != null &&
            _selectedHour != "hour" &&
            _selectedMin != "min" &&
            _selectedAP != "AM/PM") {
          return true;
        }
        break;
      case "GYM":
        if (_selectedGym != "gym") {
          return true;
        }
        break;
      case "CLIMBERS":
        if (_climbers.isNotEmpty) {
          return true;
        }
        break;
      default:
    }
    return false;
  }

  void createSession() {
    final _rows = ["DATETIME", "GYM", "CLIMBERS"];
    for (final row in _rows) {
      if (!validateInput(row)) {
        const snackBar = SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.amber,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
    }
    Session sess = Session(
        date: _dateController.text,
        gym: _selectedGym,
        name: _climbers,
        time1: _selectedHour,
        time2: _selectedMin,
        time3: _selectedAP.toUpperCase());

    apiCreateSession(sess).then((value) {
      if (value.statusCode == 200) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Success!'),
                actions: [
                  IconButton(
                      onPressed: () {
                        resetState();
                        Navigator.of(context).pop();
                        DefaultTabController.of(context)?.animateTo(0);
                      },
                      icon: const Icon(Icons.done_outline))
                ],
              );
            });
      }
    });
  }

  Widget getPendingTickButton(String rowName) {
    return ShakeAnimatedWidget(
      enabled: !validateInput(rowName),
      duration: const Duration(milliseconds: 1500),
      shakeAngle: Rotation.deg(z: 5),
      curve: Curves.linear,
      child: IconButton(
          onPressed: () {},
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: validateInput(rowName)
                ? const Icon(
                    Icons.done_outline,
                    key: ValueKey('icon1'),
                  )
                : const Icon(
                    Icons.warning_amber,
                    key: ValueKey('icon2'),
                    color: Colors.amber,
                  ),
          )),
    );
  }

  Widget getHourDropdown() {
    return DropdownButton<String>(
      hint: Text(_selectedHour),
      items: <String>[for (var i = 1; i <= 12; i++) i.toString()]
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {
        if (_ != null) {
          _selectHour(_);
        }
      },
    );
  }

  Widget getMinDropdown() {
    return DropdownButton<String>(
      hint: Text(_selectedMin),
      items: <String>["00", "30"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {
        if (_ != null) {
          _selectMin(_);
        }
      },
    );
  }

  Widget getAPDropdown() {
    return DropdownButton<String>(
      hint: Text(_selectedAP),
      items: <String>["AM", "PM"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {
        if (_ != null) {
          _selectAP(_);
        }
      },
    );
  }

  Widget getGymDropdown() {
    return DropdownButton<String>(
      isExpanded: true,
      hint: Text(
        _selectedGym,
        overflow: TextOverflow.ellipsis,
      ),
      items: _gyms.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: (_) {
        if (_ != null) {
          _selectGym(_);
        }
      },
    );
  }

  Widget getInputRowDate() {
    return ListTile(
      title: TextField(
        // enabled: false,
        controller: _dateController,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
            labelText: "set date and time",
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.secondary)),
      ),
      leading: IconButton(
        icon: const Icon(Icons.calendar_month_outlined),
        onPressed: () => _selectDate(context),
      ),
      trailing: getPendingTickButton("DATETIME"),
      subtitle: Row(children: [
        getHourDropdown(),
        const SizedBox(
          width: 2,
        ),
        getMinDropdown(),
        const SizedBox(
          width: 2,
        ),
        getAPDropdown()
      ]),
    );
  }

  Widget getInputRowWhere() {
    return ListTile(
      title: getGymDropdown(),
      leading: IconButton(
        icon: const Icon(
          Icons.location_pin,
        ),
        onPressed: () {},
      ),
      trailing: getPendingTickButton("GYM"),
    );
  }

  Widget getInputRowClimbers() {
    return ListTile(
      title: TextField(
        controller: _climbersController,
        onChanged: (_) {
          _setClimbers(_);
        },
        decoration: InputDecoration(
            labelText: 'climber names',
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.secondary)),
      ),
      leading: IconButton(
          onPressed: () {}, icon: const Icon(Icons.people_outline_rounded)),
      trailing: getPendingTickButton("CLIMBERS"),
    );
  }

  Widget getRowActionButtons() {
    return ListTile(
      title: Center(
        child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary,
              ),
              shape: MaterialStateProperty.all(
                const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
              ),
            ),
            onPressed: () {
              createSession();
            },
            child: Text(
              'Jio',
              style: Theme.of(context).textTheme.headline6,
            )),
      ),
      leading:
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_right)),
      trailing: IconButton(
          onPressed: () {
            resetState();
          },
          icon: const Icon(Icons.refresh_outlined)),
    );
  }

  Widget getTitleRow() {
    return ListTile(
      title: Center(
        child: Text(
          'Session Details',
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.apply(color: kShrineBrown400),
        ),
      ),
    );
  }

  Widget getRandomQuoteRow() {
    return Column(children: [
      AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
              'Some say it is more fun to climb with friends.\nI tried. It\'s true!',
              speed: const Duration(milliseconds: 50)),
        ],
        isRepeatingAnimation: false,
        displayFullTextOnTap: true,
        onFinished: () {
          setState(() {
            _showPastSessionsButton = true;
          });
        },
      ),
      Align(
        alignment: Alignment.center,
        child: _showPastSessionsButton
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                // TODO: animate this
                child: OpenContainer(
                    closedColor: kShrineBrown400,
                    closedBuilder: (context, action) {
                      return TextButton(
                          child: const Text('See Past Sessions'),
                          onPressed: () {
                            action();
                          });
                    },
                    openBuilder: (context, action) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                        child: Column(children: [
                          const ListTile(
                            title: Center(child: Text("Past Sessions")),
                          ),
                          getPastSessionList(),
                          IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () {
                              action();
                            },
                          )
                        ]),
                      );
                    }))
            : Container(),
      )
    ]);
  }

  Widget getPastSessionList() {
    return Container(
      // decoration: TextDecoration,
      child: pastSessions.isEmpty
          ? const Text('loading past sessions...')
          : SizedBox(
              height: 500,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                shrinkWrap: true,
                itemBuilder: (_, idx) {
                  // card = Card()
                  return ListTile(
                    title: Text(
                      pastSessions[idx],
                      style: const TextStyle(height: 1.2, fontSize: 14),
                    ),
                  );
                },
                itemCount: pastSessions.length,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500, minWidth: 400),
            child: SafeArea(
              child: ListView(children: [
                getTitleRow(),
                getInputRowDate(),
                const SizedBox(height: 10),
                getInputRowWhere(),
                const SizedBox(height: 10),
                getInputRowClimbers(),
                const SizedBox(height: 10),
                getRowActionButtons(),
                const Divider(
                  height: 10,
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 20),
                getRandomQuoteRow(),
              ]),
            ),
          ),
        ));
  }
}
