import 'package:climbjio/colors.dart';
import 'package:climbjio/constAndConfig.dart';
import 'package:climbjio/globals.dart';
import 'package:climbjio/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class userProfileEntry extends StatefulWidget {
  const userProfileEntry({Key? key}) : super(key: key);

  @override
  State<userProfileEntry> createState() => _userProfileEntryState();
}

class _userProfileEntryState extends State<userProfileEntry> {
  @override
  void initState() {
    super.initState();
  }

  void refresh() {
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
                  insetPadding: EdgeInsets.only(top: 60, left: 250),
                  elevation: 10,
                  backgroundColor: kClimbjioPink400,
                  alignment: Alignment.topCenter,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 50, maxHeight: 150),
                      child: userManager.isLoggedin
                          ? ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text('< Tap to logout'),
                              leading: IconButton(
                                  onPressed: () {
                                    logout().then((value) => refresh()).then(
                                        (value) => Navigator.of(context).pop());
                                  },
                                  icon: FaIcon(FontAwesomeIcons.signOutAlt)),
                            )
                          : ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text('Supported channels: '),
                              trailing: Wrap(children: [
                                IconButton(
                                    onPressed: () {
                                      loginWithGoogle()
                                          .then((value) => refresh())
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    },
                                    icon: FaIcon(FontAwesomeIcons.google)),
                              ]),
                            )),
                );
              });
        },
        child: Text(userManager.nickName,
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: kClimbjioBrown400,
                fontSize: 18.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: userProfile(),
    );
  }
}





// Wrap(
//                     alignment: WrapAlignment.start,
//                     children: [
//                       ListTile(
//                         title: Row(
//                           children: [
//                             FittedBox(
//                                 fit: BoxFit.scaleDown,
//                                 child: Text('Login with ')),
//                             FaIcon(FontAwesomeIcons.google),
//                           ],
//                         ),
//                       ),
//                       ListTile(
//                         title: Text('Logout'),
//                       )
//                     ],
//                   ),