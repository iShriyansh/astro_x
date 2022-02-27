import 'package:astro_tak/presentation/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

AppBar customAppBar(BuildContext context,
    {List<Widget>? trailing, bool isShowBackButton = false}) {
  return AppBar(
    leading: isShowBackButton
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              size: 28,
            ))
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                //Todo: open drawer
              },
              child: Image.asset(
                'assets/images/hamburger.png',
              ),
            ),
          ),
    centerTitle: true,
    title: Column(
      children: [
        SizedBox(width: 55, child: Image.asset('assets/images/icon.png'))
      ],
    ),
    actions: trailing ??
        [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Profile()));
            },
            child: Container(
                margin: const EdgeInsets.only(right: AppTheme.margin),
                width: 25,
                child: Image.asset('assets/images/profile.png')),
          ),
        ],
  );
}
