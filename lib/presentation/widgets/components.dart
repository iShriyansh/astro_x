import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  final Function? onPressed;
  final double height;
  final double? width;
  double? labelSize;
  final String label;
  final TextStyle? labelTextStyle;

  CustomButton1(
      {Key? key,
      this.onPressed,
      this.height = 35,
      this.width,
      this.labelTextStyle,
      this.label = "Add money",
      this.labelSize = 14})
      : super(key: key) {
    labelSize = (height / 2.5);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed?.call(),
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: const BorderSide(color: Colors.black, width: 1.5)),
        child: Text(
          label,
          style: labelTextStyle ??
              TextStyle(
                  color: CupertinoColors.systemIndigo,
                  fontWeight: FontWeight.bold,
                  fontSize: labelSize ?? 14),
        ),
      ),
    );
  }
}
