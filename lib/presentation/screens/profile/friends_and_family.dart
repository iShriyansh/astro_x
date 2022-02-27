import 'package:astro_tak/data/models/friends_and_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/user/user_bloc.dart';
import '../../theme/theme.dart';
import '../../widgets/components.dart';

class FriendsAndFamilyProfile extends StatefulWidget {
  const FriendsAndFamilyProfile({
    Key? key,
  }) : super(key: key);

  @override
  _FriendsAndFamilyProfileState createState() =>
      _FriendsAndFamilyProfileState();
}

class _FriendsAndFamilyProfileState extends State<FriendsAndFamilyProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FriendAndFamilyInfo(),
    );
  }
}

class FriendAndFamilyInfo extends StatefulWidget {
  const FriendAndFamilyInfo({Key? key}) : super(key: key);

  @override
  _FriendAndFamilyInfoState createState() => _FriendAndFamilyInfoState();
}

class _FriendAndFamilyInfoState extends State<FriendAndFamilyInfo> {
  int _walletBalance = 0;

  late UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetFriendsAndFamily());
    super.initState();
  }

  void showSnackbarWithMessage(String msg) {
    SnackBar snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildRelatives() {
      // Show sneackbar
      return BlocConsumer<UserBloc, UserState>(listener: (context, state) {
        if (state is DeletingProfile) {
          showSnackbarWithMessage(state.message);
        } else if (state is ProfileDeleted) {
          showSnackbarWithMessage(state.message);
        }
      },
          //Do not build while showing toast message
          buildWhen: (prevState, currentState) {
        if (prevState is FriendsAndFamilyLoaded &&
            currentState is DeletingProfile) return false;
        return true;
      },
          //Build
          builder: (context, state) {
        if (state is FriendsAndFamilyLoaded) {
          final relatives = state.friendsAndFamily.data.allRelatives;
          return relatives.length == 0
              ? Text("No Relatives")
              : Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: ListView.builder(
                      itemCount: relatives.length,
                      itemBuilder: (context, index) {
                        final relative = relatives[index];
                        return Container(
                          child: Card(
                            child: Container(
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            rowText(relative.firstName),
                                            (relative.lastName != "")
                                                ? rowText(relative.lastName)
                                                : Container(),
                                          ],
                                        ),
                                        rowText(
                                            "${relative.birthDetails.dobDay}/${relative.birthDetails.dobMonth}/${relative.birthDetails.dobYear}"),
                                        rowText(
                                          " ${relative.birthDetails.tobHour}: ${relative.birthDetails.tobMin}",
                                        ),
                                        rowText(
                                          relative.relation,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppTheme.margin,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (ctx) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      title: Text(
                                                        "Do you really to Delete?",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      actions: [
                                                        MaterialButton(
                                                          minWidth: 120,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          child: Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () {
                                                            _userBloc.add(
                                                                DeleteFriendOrFamilyMember(
                                                                    relative
                                                                        .uuid));
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        MaterialButton(
                                                          minWidth: 120,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          child: Text(
                                                            "No",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
        } else if (state is FriendsAndFamilyLoading) {
          return Container(
              height: MediaQuery.of(context).size.height / 2.5,
              alignment: Alignment.center,
              child: CupertinoActivityIndicator());
        } else if (state is FriendsAndFamilyError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return Center(
            child: Text("Something went wrong!"),
          );
        }
      });
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: AppTheme.margin * 3,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.margin * 2),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CupertinoColors.systemIndigo.withOpacity(.1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: CupertinoColors.systemIndigo,
                ),
                SizedBox(
                  width: AppTheme.margin,
                ),
                Text(
                  "Wallet Balance : ₹ $_walletBalance",
                  style: GoogleFonts.montserrat(
                      color: CupertinoColors.systemIndigo, fontSize: 16),
                ),
                SizedBox(
                  width: AppTheme.margin / 2,
                ),
                CustomButton1(
                  height: 30,
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppTheme.margin * 2,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rowText(
                        "Name",
                        flex: 2,
                        color: CupertinoColors.systemIndigo.withOpacity(.6),
                      ),
                      rowText(
                        "DOB",
                        flex: 0,
                        color: CupertinoColors.systemIndigo.withOpacity(.6),
                      ),
                      rowText(
                        "TOB",
                        flex: 0,
                        color: CupertinoColors.systemIndigo.withOpacity(.6),
                      ),
                      rowText(
                        "Relation",
                        flex: 0,
                        color: CupertinoColors.systemIndigo.withOpacity(.6),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 1, child: Container())
              ],
            ),
          ),
          SizedBox(
            height: AppTheme.margin,
          ),
          _buildRelatives(),
          SizedBox(
            height: AppTheme.margin * 4,
          ),
        ]),
      ),
    );
  }

  Widget rowText(String text, {Color? color, int flex = 1}) {
    return Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 50),
        child: Text(text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: color ?? Colors.black54, fontSize: 11)),
      ),
    );
  }
}
