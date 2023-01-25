// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:usis_2/Screen/addJob.dart';
import 'package:usis_2/Screen/home.dart';
import 'package:usis_2/constants.dart';

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final Function? touched;
  final bool active;
  const NavBarItem({
    super.key,
    required this.icon,
    this.touched,
    required this.active,
  });
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (widget.icon == Feather.log_out) {
            logOutDialog(
                    context,
                    "UYGULAMADAN ÇIK",
                    "Uygulamadan çıkmak istediğinizden emin misiniz?",
                    DialogType.info)
                .show();
          } else {
            widget.touched!();
          }
        },
        splashColor: Colors.white,
        hoverColor: Colors.white12,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            children: [
              SizedBox(
                height: 60.0,
                width: 80.0,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 475),
                      height: 35.0,
                      width: 5.0,
                      decoration: BoxDecoration(
                        color:
                            widget.active ? Colors.white : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Icon(
                        widget.icon,
                        color: widget.active ? Colors.white : Colors.white54,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
