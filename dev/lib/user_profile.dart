// ignore_for_file: camel_case_types

import 'package:climbjio/colors.dart';
import 'package:climbjio/components/auth/user_manager.dart';
import 'package:climbjio/constAndConfig.dart';
import 'package:climbjio/globals.dart';
import 'package:climbjio/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

ValueNotifier<String> nickNameNotifier = ValueNotifier("");

class userProfileEntry extends StatefulWidget {
  const userProfileEntry({Key? key}) : super(key: key);

  @override
  State<userProfileEntry> createState() => _userProfileEntryState();
}

class _userProfileEntryState extends State<userProfileEntry> {
  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    await userManager.loadFromLocalPrefs();
    nickNameNotifier.value = userManager.nickName;
    setState(() {});
  }

  Widget userProfile() {
    // bool expanded = false;
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  insetPadding: const EdgeInsets.only(top: 60, right: 30),
                  elevation: 10,
                  backgroundColor: kClimbjioPink400,
                  alignment: Alignment.topCenter,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: userManager.isLoggedin
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 300,
                                  child: editNickNameRow(),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: AskForSuggestionRow(),
                                ),
                                SizedBox(
                                  width: 300,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    title: const Text(
                                      'Tap to logout > ',
                                      textAlign: TextAlign.right,
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          logout()
                                              .then((value) => refresh())
                                              .then((value) =>
                                                  Navigator.of(context).pop());
                                        },
                                        icon: const FaIcon(
                                            FontAwesomeIcons.rightFromBracket)),
                                  ),
                                ),
                              ],
                            )
                          : ListTile(
                              contentPadding: const EdgeInsets.all(20),
                              title: const Text('Supported channels: '),
                              trailing: Wrap(children: [
                                IconButton(
                                    onPressed: () async {
                                      var newUser = await loginWithGoogle();
                                      if (newUser) {
                                        await apiCreateUserData();
                                      } else {
                                        await checkIfUserHasDataIfNotCreate();
                                      }
                                      refresh();
                                      Navigator.of(context).pop();
                                    },
                                    icon:
                                        const FaIcon(FontAwesomeIcons.google)),
                              ]),
                            )),
                );
              });
        },
        child: ValueListenableBuilder(
            valueListenable: nickNameNotifier,
            builder: (context, value, widget) {
              return Text('$value',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kClimbjioBrown400,
                      fontSize: 18.0));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: userProfile(),
    );
  }
}

class editNickNameRow extends StatefulWidget {
  const editNickNameRow({Key? key}) : super(key: key);

  @override
  State<editNickNameRow> createState() => _editNickNameRowState();
}

class _editNickNameRowState extends State<editNickNameRow> {
  bool _editting = false;
  final _nickNameController = TextEditingController();
  final _nickNameNode = FocusNode();

  @override
  void initState() {
    // no need to test if user is logged in here.
    // becoz only logged in user can see this dialog.
    _nickNameController.text = userManager.nickName;
    super.initState();
  }

  _setNickNameForLoggedInUser() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 15),
      child: ListTile(
        title: TextField(
          enabled: _editting,
          focusNode: _nickNameNode,
          controller: _nickNameController,
          onChanged: (_) {
            // do nothing. updateo only when check button is pressed.
          },
          textAlign: TextAlign.center,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '(This will be used to auto-fill when creating/joining sessions)',
            style: TextStyle(fontSize: 10),
          ),
        ),
        trailing: _editting
            ? IconButton(
                onPressed: (() async {
                  setState(() {
                    _editting = false;
                  });
                  userManager.nickName = _nickNameController.text;
                  await apiSetUserNickName(userManager.nickName);
                  await userManager.saveToLocalPrefs(
                      UM_nickName, userManager.nickName);
                  nickNameNotifier.value =
                      userManager.nickName; // trigger notifier
                }),
                icon: FaIcon(FontAwesomeIcons.check),
              )
            : IconButton(
                onPressed: (() {
                  setState(() {
                    _editting = true;
                  });
                }),
                icon: FaIcon(FontAwesomeIcons.penToSquare),
              ),
      ),
    );
  }
}

class AskForSuggestionRow extends StatelessWidget {
  const AskForSuggestionRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Text(
              "< Greetings! What other functions would be nice for this teeny tiny app? Let me know in wechat! >",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.apply(fontStyle: FontStyle.italic)),
        ),
      ),
    );
  }
}
