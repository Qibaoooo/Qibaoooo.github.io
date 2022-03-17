import 'package:climbjio/colors.dart';
import 'package:climbjio/network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget userProfile(context, refreshfunction) {
  bool expanded = false;

  return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                alignment: Alignment.topLeft,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(40)),
                child: Wrap(
                  alignment: WrapAlignment.start,
                ),
              );
            });
      },
      icon: const FaIcon(FontAwesomeIcons.user));
}
