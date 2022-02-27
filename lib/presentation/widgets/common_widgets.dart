import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final Function(String value) onChanged;
  const CustomDropDown({Key? key, required this.items, required this.onChanged})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 35,
          ),
          elevation: 16,
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),
          underline: Container(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });

            widget.onChanged(dropdownValue);
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

Text formLabel(String label) {
  return Text(
    label,
    style:
        GoogleFonts.montserrat(color: Colors.grey, fontWeight: FontWeight.w400),
  );
}

InputDecoration inputDecorationx(String placeHolder) {
  return InputDecoration(
      hintText: placeHolder,
      hintStyle: TextStyle(color: Colors.grey),
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CupertinoColors.activeBlue, width: 1.4),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Color(
              0xffE3E9EE,
            ),
            width: 1.4),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: CupertinoColors.destructiveRed, width: 1.4)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: CupertinoColors.destructiveRed, width: 1.4)),
      errorStyle: TextStyle(
        color: CupertinoColors.destructiveRed,
      ));
}

class Field extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final String? label;
  final int? maxLength;
  final String? placeHolder;
  final TextInputType? textInputType;

  const Field({
    Key? key,
    this.onChange,
    this.validator,
    this.label,
    this.maxLength,
    this.placeHolder,
    this.controller,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null ? formLabel(label ?? "") : Container(),
        SizedBox(height: AppTheme.margin),
        Container(
            child: TextFormField(
                controller: controller,
                maxLength: maxLength,
                keyboardType: textInputType,
                inputFormatters: [],
                validator: validator,
                style: TextStyle(fontSize: 16),
                cursorColor: CupertinoColors.activeBlue,
                decoration: inputDecorationx(placeHolder ?? ""))),
      ],
    );
  }
}

class OutlinedDropDown extends StatelessWidget {
  final List<String> items;
  final Function(int?, String?) onChange;
  final String? label;
  final String? Function(int?)? validator;
  final int? defaultValue;

  const OutlinedDropDown({
    Key? key,
    required this.items,
    required this.onChange,
    this.label,
    this.validator, this.defaultValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null ? formLabel(label ?? "") : Container(),
        SizedBox(height: label != null ? AppTheme.margin : 0),
        DropdownButtonFormField(
            validator: validator,
            isDense: true,
            value: defaultValue,
            decoration: inputDecorationx(""),
            items: [
              for (int i = 0; i < items.length; i++)
                DropdownMenuItem<int>(
                  child: Text(items[i]),
                  value: i,
                )
            ],
            onChanged: (int? index) {
              onChange(index, index != null ? items[index] : "");
            }),
      ],
    );
  }
}
