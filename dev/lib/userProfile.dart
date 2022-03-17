import 'dart:ffi';

import 'package:climbjio/network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget userProfile(context, refreshfunction) {
  bool expanded = false;

  // Widget v2 = Flow(delegate: UserProfileFlowDelegate());

  return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                alignment: Alignment.topLeft,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: Container(
                  decoration: const BoxDecoration(
                    backgroundBlendMode: BlendMode.colorBurn,
                    color: Colors.transparent,
                  ),
                  width: 100,
                  height: 300,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Wrap(spacing: 20, children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.signInAlt),
                        onPressed: () {
                          logout().then((value) => {refreshfunction()});
                        },
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.google),
                        onPressed: () {
                          loginWithGoogle()
                              .then((value) => {refreshfunction()});
                        },
                      ),
                    ]),
                  ),
                ),
              );
            });
      },
      icon: FaIcon(FontAwesomeIcons.user));
}

// class UserProfileFlowDelegate extends FlowDelegate {
//   @override
//   void pai
// }
