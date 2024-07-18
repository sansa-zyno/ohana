import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDialogWidget extends StatelessWidget {
  final String? image;
  final String titleText;
  final String subText;
  //final Color borderColor;

  ShowDialogWidget(
      {required this.titleText, required this.subText, this.image});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image == null
                ? Center(
                    child: Icon(
                      Icons.bug_report,
                      size: 50,
                      color: Colors.red,
                    ),
                  )
                : Center(
                    child: Image.asset(
                      image!,
                      height: 100,
                    ),
                  ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              text: titleText,
              fontFamily: GoogleFonts.poppins().fontFamily,
              weight: FontWeight.bold,
              textAlign: TextAlign.center,
              size: 22,
            ),
            SizedBox(
              height: 15,
            ),
            /* CustomText(
              text: subText,
              fontFamily: GoogleFonts.poppins().fontFamily,
              size: 16,
            )*/
          ],
        ),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(appColor)),
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ]); /*AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(
            color: borderColor,
          )),
      title: Text(titleText),
      content: Text(subText),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "OK",
            style: TextStyle(color: borderColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );*/
  }
}
