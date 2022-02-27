import 'package:astro_tak/presentation/screens/profile/profile_tab.dart';
import 'package:astro_tak/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  int groupValue = 0;
  @override
  Widget build(BuildContext context) {
    Widget _buildLogoutButton() {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                side:
                    BorderSide(color: Theme.of(context).colorScheme.secondary)),
            onPressed: () {},
            child: Text(
              "Logout",
              style: TextStyle(
                  fontSize: 12, color: Theme.of(context).colorScheme.secondary),
            )),
      );
    }

    return Scaffold(
      appBar: customAppBar(context,
          isShowBackButton: true, trailing: [_buildLogoutButton()]),
      body: Container(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorWeight: 1.5,
              labelStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300, fontSize: 16),
              labelColor: Colors.orange,
              tabs: <Widget>[
                Tab(
                  text: "My Profile",
                ),
                Tab(text: "Order History"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ProfileTab(),
                Center(
                  child: Text("It's rainy here"),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
