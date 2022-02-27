import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

 

import 'package:astro_tak/presentation/bloc/user/user_bloc.dart';
import 'package:astro_tak/presentation/theme/theme.dart';
import 'package:astro_tak/presentation/widgets/common_widgets.dart';

import '../../../data/repositories/add_profile_payload.dart';

class AddNewProfile extends StatefulWidget {


  const AddNewProfile({
    Key? key,

  }) : super(key: key);

  @override
  _AddNewProfileState createState() => _AddNewProfileState();
}

class _AddNewProfileState extends State<AddNewProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobDDController = TextEditingController();
  TextEditingController _dobMMController = TextEditingController();
  TextEditingController _dobYYYYController = TextEditingController();
  TextEditingController _tobHHController = TextEditingController();
  TextEditingController _tobMMController = TextEditingController();
  TextEditingController _birthPlaceController = TextEditingController();

  String? selectedGender;
  //0 male, 1 female
  int? selectedGenderId;
  int? selectedRelationId;

  String amPm = "am";

  @override
  void initState() {
    _bloc = context.read<UserBloc>();
    super.initState();
  }



  void addProfile() {
    //todo: need more checks
    List fullName = _nameController.text.split(" ");
    AddProfilePayLoad payLoad = AddProfilePayLoad(
        birthDetails: BirthDetails(
          dobDay: parseField<int>(_dobDDController),
          dobMonth: parseField<int>(_dobMMController),
          dobYear: parseField<int>(_dobYYYYController),
          tobHour: parseField<int>(_tobHHController),
          tobMin: parseField<int>(_tobMMController),
          meridiem: amPm.toUpperCase(),
        ),
        birthPlace: BirthPlace(
            placeId: "sdfsdfdsf", placeName: parseField(_birthPlaceController)),
        firstName: fullName.first,
        lastName: fullName.last,
        //relationId: selectedRelationId,//! Relation is is not provided
        relationId: 3,
        gender: selectedGender?.toUpperCase() ?? "");

    print(payLoad.toJson());
    _bloc.add(AddNewProfileEvent(addProfilePayLoad: payLoad));
  }

  late UserBloc _bloc;

  C parseField<C>(TextEditingController value) {
    try {
      if (C == int) {
        return int.parse(value.text) as C;
      }
    } catch (e) {
      throw Exception("Value conversion fail");
    }

    return value.text as C;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Field(
                    label: "Name",
                    controller: _nameController,
                    validator: (name) {
                      if (name != null) {
                        if (name.length <= 1) {
                          return "Enter Valid Name";
                        }
                      } else {
                        return "Enter Name";
                      }
                    },
                  ),
                  SizedBox(
                    height: AppTheme.margin * 2,
                  ),
                  formLabel("Date Of Birth"),
                  Row(
                    children: [
                      Expanded(
                        child: Field(
                          controller: _dobDDController,
                          maxLength: 2,
                          placeHolder: "DD",
                          textInputType: TextInputType.number,
                          validator: (name) {
                            if (name != null) {
                              if (name.length <= 0) {
                                return "Invalid DD";
                              }
                            } else {
                              return "Enter DD";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: AppTheme.margin,
                      ),
                      Expanded(
                        child: Field(
                          controller: _dobMMController,
                          textInputType: TextInputType.number,
                          maxLength: 2,
                          placeHolder: "MM",
                          validator: (name) {
                            if (name != null) {
                              if (name.length <= 0) {
                                return "Invalid MM";
                              }
                            } else {
                              return "Enter MM";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: AppTheme.margin,
                      ),
                      Expanded(
                        child: Field(
                          controller: _dobYYYYController,
                          textInputType: TextInputType.number,
                          maxLength: 4,
                          placeHolder: "YYYY",
                          validator: (name) {
                            if (name != null) {
                              if (name.length <= 3) {
                                return "Invalid YYY";
                              }
                            } else {
                              return "Enter YYYY";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppTheme.margin * 2,
                  ),
                  formLabel("Time Of Birth"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Field(
                          controller: _tobHHController,
                          maxLength: 2,
                          placeHolder: "HH",
                          textInputType: TextInputType.number,
                          validator: (name) {
                            if (name != null) {
                              if (name.length <= 0) {
                                return "Invalid HH";
                              }
                            } else {
                              return "Enter HH";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: AppTheme.margin,
                      ),
                      Expanded(
                        child: Field(
                          controller: _tobMMController,
                          maxLength: 2,
                          placeHolder: "MM",
                          textInputType: TextInputType.number,
                          validator: (name) {
                            if (name != null) {
                              if (name.length <= 0) {
                                return "Invalid MM";
                              }
                            } else {
                              return "Enter MM";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: AppTheme.margin,
                      ),
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.only(top: 9),
                          child: CupertinoSlidingSegmentedControl<String>(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              groupValue: amPm,
                              thumbColor: Colors.indigo,
                              children: <String, Widget>{
                                "am": Container(
                                  child: Text(
                                    'AM',
                                    style: TextStyle(
                                        color: amPm == "am"
                                            ? Colors.white70
                                            : Colors.black),
                                  ),
                                ),
                                "pm": Container(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      'PM',
                                      style: TextStyle(
                                          color: amPm == "pm"
                                              ? Colors.white70
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              },
                              onValueChanged: (value) {
                                setState(() {
                                  amPm = value ?? "am";
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppTheme.margin * 2,
                  ),
                  Field(
                    label: "Place Of Birth",
                    controller: _birthPlaceController,
                    validator: (value) {
                      if (value != null) {
                        if (value.length <= 3) {
                          return "Enter valid address";
                        }
                      } else {
                        return "Please select city";
                      }
                    },
                  ),
                  SizedBox(
                    height: AppTheme.margin * 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedDropDown(
                          label: "Gender",
                          items: ["Male", "Female"],
                          defaultValue: selectedGenderId,
                          validator: (value) {
                            if (value == null) {
                              return "Invalid Gender";
                            }
                          },
                          onChange: (index, gender) {
                            print(gender);
                            selectedGender = gender;
                          },
                        ),
                      ),
                      SizedBox(
                        width: AppTheme.margin,
                      ),
                      Expanded(
                        child: OutlinedDropDown(
                          label: "Relation",
                          defaultValue: selectedRelationId,
                          items: [
                            "Brother",
                            "Sister",
                            "Mother",
                            "Father",
                            "Friend",
                            "Father in law",
                            "Son"
                          ],
                          validator: (value) {
                            if (value == null) {
                              return "Invalid Relation";
                            }
                          },
                          onChange: (index, relation) {
                            print(relation);
                            selectedRelationId = index ?? 0;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppTheme.margin * 3,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: BlocListener<UserBloc, UserState>(
                      listener: (context, state) {
                        if (state is AddingProfile) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Saving Please wait...",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                  ],
                                ));
                              });
                        }

                        if (state is ProfileAdded) {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.messsage)));
                        }

                        if (state is AddingProfileError) {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                      },
                      child: MaterialButton(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Save Changes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              addProfile();
                            }
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
