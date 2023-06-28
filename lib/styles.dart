import 'package:flutter/material.dart';

Color blackColor = Colors.black;
Color whiteColor = Colors.white;

double defaultFontSize = 24;
double extraSmallFontSize = 8;
double smallFontSize = 16;
double largeFontSize = 32;

TextStyle titleList = TextStyle(fontSize: largeFontSize);
TextStyle nameList = TextStyle(fontSize: defaultFontSize);
TextStyle positionList =
    TextStyle(fontSize: defaultFontSize, fontWeight: FontWeight.bold);
TextStyle favoritesList = TextStyle(fontSize: smallFontSize);
TextStyle formSearch = TextStyle(fontSize: defaultFontSize, color: whiteColor);
TextStyle titleContentCollapsed = TextStyle(fontSize: defaultFontSize);
TextStyle childrenNameContentCollapsed = TextStyle(fontSize: smallFontSize);
TextStyle childrenValueContentCollapsed =
    TextStyle(fontSize: smallFontSize, fontWeight: FontWeight.bold);

Divider defaultDivider = Divider(
  color: blackColor,
  height: 1,
  thickness: 1,
);
Widget loadingIndicator = Center(
    child: CircularProgressIndicator(
  color: blackColor,
));

Widget empty = const SizedBox();

Widget widthButton(
  BuildContext context,
  String text,
  CrossAxisAlignment position,
  Function() func,
) {
  return InkWell(
    child: Container(
        padding: EdgeInsets.symmetric(horizontal: extraSmallFontSize),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: position,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: defaultFontSize, color: blackColor),
            ),
          ],
        )),
    hoverColor: blackColor,
    onTap: func,
  );
}

Widget titleButton(
  BuildContext context,
  String text,
  String title,
  Function() func,
) {
  return InkWell(
    child: Container(
        padding: EdgeInsets.only(left: extraSmallFontSize),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: defaultFontSize, color: blackColor),
            ),
            SizedBox(width: smallFontSize),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: smallFontSize),
                  color: blackColor,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: defaultFontSize, color: whiteColor),
                      ),
                    ],
                  )),
            )
          ],
        )),
    hoverColor: blackColor,
    onTap: func,
  );
}
