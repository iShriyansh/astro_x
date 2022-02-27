import 'dart:ui';

import 'package:astro_tak/presentation/bloc/auth/auth_cubit.dart';
import 'package:astro_tak/presentation/bloc/user/user_bloc.dart';
import 'package:astro_tak/presentation/screens/profile/add_new_profile.dart';
import 'package:astro_tak/presentation/screens/profile/friends_and_family.dart';
import 'package:astro_tak/presentation/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/components.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  bool editProfile = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is ProfileAdded) {
          setState(() {
            editProfile = false;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.white,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8)),
              tabs: <Widget>[
                Tab(
                  text: "Basic Profile",
                ),
                Tab(text: "Friends and Family Profile"),
              ],
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Container(),
                !editProfile
                    ? Column(
                        children: [
                          FriendAndFamilyInfo(),
                          MaterialButton(
                              padding: EdgeInsets.all(AppTheme.margin * 1.5),
                              child: Text("+ Add New Profile",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                setState(() {
                                  editProfile = true;
                                });
                              })
                        ],
                      )
                    : Column(
                        children: [
                          AppBar(
                            title: Text(
                              "Add New Profile",
                              style: GoogleFonts.montserrat(fontSize: 18),
                            ),
                            leading: IconButton(
                                onPressed: () {
                                  setState(() {
                                    editProfile = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black87,
                                )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          AddNewProfile(),
                        ],
                      )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
