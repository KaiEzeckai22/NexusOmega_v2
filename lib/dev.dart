import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:dbcrypt/dbcrypt.dart';
//import 'package:flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
//import 'package:another_flushbar/flushbar_helper.dart';
//import 'package:another_flushbar/flushbar_route.dart';
//import 'package:crypto/crypto.dart';
//import 'package:encrypt/encrypt.dart' as encrypt;
//import 'package:overlay_support/overlay_support.dart';

//import 'package:flushbar/flushbar_helper.dart';
//import 'dart:async';

double contentSize = 20, titleSize = 37, authorIDSize = 13;
int titleFontIndex = 0, authorFontIndex = 0, contentFontIndex = 0;
int counter = 0;

doNoting() {}
none() {}

resetParameters() {
  contentSize = 20;
  titleSize = 37;
  authorIDSize = 13;
  titleFontIndex = 0;
  authorFontIndex = 0;
  contentFontIndex = 0;
}

String backSpaceString(String str) {
  String result = '';
  if (str.isNotEmpty) {
    result = str.substring(0, str.length - 1);
  }

  return result;
}

void share(BuildContext context, Object any) {
  //gkmnfinal RenderBox box = context.findRenderObject();

  Share.share(any.toString());
}

List<PopupItem> colourMenu = cxColourList.toPopUpList();
//   PopupItem(1, 'red'),
//   PopupItem(2, 'orange'),
//   PopupItem(3, 'yellow'),
//   PopupItem(4, 'green'),
//   PopupItem(4, 'blue'),
//   PopupItem(5, 'violet'),
//   PopupItem(6, 'pink'),
//   PopupItem(7, 'silver'),
//   PopupItem(8, 'cyan'),
//   PopupItem(9, 'grey'),
//   PopupItem(10, 'white'),
//   PopupItem(10, 'gold'),
//   PopupItem(10, 'teal'),
//   PopupItem(10, 'white'),
//   PopupItem(10, 'gold'),
//   PopupItem(10, 'teal'),
//   PopupItem(10, 'white'),
//   PopupItem(10, 'gold'),
//   PopupItem(10, 'teal'),
//   // PopupItem(
//   //     0, 'nukeTest'), // <<< UNCOMMENT THIS TO ACTIVATE NUKE TEST AREA/BUTTON
// ];

class CxColour {
  final String name;
  final Color colour;
  CxColour(this.name, this.colour);
}

class CxColourList {
  final List<CxColour> colours;
  CxColourList(this.colours);

  List<String> namesToString() {
    List<String> names = [];
    for (int i = 0; i < colours.length; i++) {
      names.add((colours[i].name).toString());
    }
    return names;
  }

  List<PopupItem> toPopUpList() {
    List<PopupItem> colourPopUp = [];
    for (int i = 0; i < colours.length; i++) {
      colourPopUp.add(PopupItem(i, (colours[i].name).toString()));
    }
    return colourPopUp;
  }
}

CxColourList cxColourList = CxColourList(colourList);

List<CxColour> colourList = [
  CxColour('pink', const Color(0xffff3c9d)),
  CxColour('lred', Colors.red),
  CxColour('red', const Color(0xffcc1c10)),
  CxColour('dred', const Color(0xff500000)),
  CxColour('orange', Colors.orange),
  CxColour('yellow', Colors.yellow),
  CxColour('green', const Color(0xff00f006)),
  CxColour('dgreen', const Color(0xff008000)),
  CxColour('lblue', Colors.lightBlue),
  CxColour('blue', Colors.blue),
  CxColour('violet', const Color(0xff8866ff)),
  CxColour('cyan', const Color(0xff07cdf8)),
  CxColour('dblue', const Color(0xff01579b)),
  CxColour('black', Colors.black),
  CxColour('grey', const Color(0xff909090)),
  CxColour('silver', const Color(0xffc0c0c0)),
  CxColour('white', Colors.white),
];

Color colour(String? colour) {
  for (int i = 0; i < colourList.length; i++) {
    if (colour == colourList[i].name) {
      return colourList[i].colour;
    }
  }
  return Colors.white;
}

Widget ctrlrField({
  required BuildContext context,
  required String fieldPrompt,
  //String initialValue,
  required TextEditingController ctrlrID,
  Color? selectedColor,
  Color? defaultColor,
  Color? errorColor,
  TextInputType? inputType,
  int? maxLines,
  bool? obscure,
  bool? autoFocus,
  bool? next,
  Function(String)? onChangeString,
  Function()? onSubmit,
  FocusNode? node,
}) {
  return TextFormField(
    //initialValue: initialValue,
    onChanged: (value) {
      if (onChangeString != null) {
        onChangeString(value);
      }
    },
    onFieldSubmitted: (value) {
      if (onSubmit != null) {
        onSubmit();
      }
    },
    focusNode: node,
    controller: ctrlrID,
    keyboardType: (inputType == null) ? TextInputType.text : inputType,
    obscureText: (obscure == null) ? false : obscure,
    autofocus: (autoFocus == null) ? false : autoFocus,
    maxLines: (maxLines == null) ? null : 1,
    textInputAction: (next != null && next == true)
        ? TextInputAction.next
        : TextInputAction.done,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: (selectedColor != null) ? selectedColor : Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: (defaultColor != null) ? defaultColor : Colors.grey,
        ),
      ),
      disabledBorder: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      labelText: fieldPrompt,
      labelStyle: cxTextStyle(style: 'normal', colour: selectedColor, size: 15),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: (errorColor != null) ? errorColor : Colors.red,
        ),
      ),
      //errorText: (ctrlrID.text.isEmpty) ? "Field is Required" : null,
    ),
    style: cxTextStyle(style: 'normal', colour: defaultColor, size: 15),
  );
}

Widget cText({String? text, Color? colour, double? size, String? style}) {
  return Text((text != null) ? text : 'test_text',
      style: cxTextStyle(style: style, colour: colour, size: size));
}

List<String> importedFonts = [
  'LexendDeca',
  'font1942',
  'atwriter',
  'Bebas',
  'Effect',
  'Philosopher',
  'Poison',
  'Timeless',
  'Average',
  'BrokenGlass',
  'Caveat',
  'CrimsonText',
  'DancingScript',
  'Fenix',
  'FrederickaTheGreat',
  'FUTHA',
  'HeavyEquipment',
  'Italianno',
  'LibreBaskerville',
  'LindenHill',
  'Luna',
  'Monofett',
  'Monoton',
  'norskode',
  'Overhaul',
  'PoiretOne',
  'Portmanteau',
  'PressStart2P',
  'PrincessSofia',
  'RobotoMono',
  'RobotoSlab',
  'Smythe',
  'SortsMillGoudy',
  'SpecialElite',
  'Stalemate',
  'Tippa',
  'Video'
];

TextStyle cxTextStyle(
    {String? style, Color? colour, double? size, String? fontFamily}) {
  double defaultSize = 20;
  // DEFAULT GREY BECAUSE WHITE FADES IN WHITE BG, BLACK FADES IN BLACK BG
  switch (style) {
    case 'bold':
      return TextStyle(
        fontFamily: fontFamily,
        color: (colour != null) ? colour : Colors.white,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        fontSize: (size != null) ? size : defaultSize,
      );
    case 'italic':
      return TextStyle(
        fontFamily: fontFamily,
        color: (colour != null) ? colour : Colors.white,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.normal,
        fontSize: (size != null) ? size : defaultSize,
      );
    case 'boldItalic':
      return TextStyle(
        fontFamily: fontFamily,
        color: (colour != null) ? colour : Colors.white,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: (size != null) ? size : defaultSize,
      );
    default:
      return TextStyle(
        fontFamily: fontFamily,
        color: (colour != null) ? colour : Colors.white,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        fontSize: (size != null) ? size : defaultSize,
      );
  }
}

Widget hfill(double height) {
  return SizedBox(height: height);
}

Widget vfill(double width) {
  return SizedBox(width: width);
}

class PopupItem {
  int value;
  String name;
  PopupItem(this.value, this.name);
}

defocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

/*
List<PopupItem> selectables = [
  PopupItem(1, "ON"),
  PopupItem(2, "OFF")
];*/

class SelectionMenu extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SelectionMenu({required this.selectables, required this.onSelection});
  final Function(String) onSelection;
  final List<PopupItem> selectables;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Colors.black,
        elevation: 20,
        enabled: true,
        icon: const Icon(Icons.settings),
        enableFeedback: true,
        onSelected: (value) {
          //defocus();
          onSelection(value.toString());
        },
        itemBuilder: (context) {
          return selectables.map((PopupItem choice) {
            return PopupMenuItem(
              value: choice.name,
              child: Text(
                choice.name,
                style: cxTextStyle(style: 'bold', colour: colour(''), size: 16),
              ),
            );
          }).toList();
        });
  }
}

SizedBox popUpMenu({
  required Function(String) onSelection,
  required List<PopupItem> selectables,
  String? text,
  TextStyle? textStyle,
  Color? buttonColour,
  Icon? icon,
  Color? iconColour,
  backgroundColour,
  borderColour,
  popupColour,
  double? height,
  width,
  fontSize,
}) {
  return SizedBox(
      height: (height != null) ? height : 50,
      width: (width != null) ? width : 50,
      child: Card(
          color: (backgroundColour != null) ? backgroundColour : Colors.black45,
          shape: ContinuousRectangleBorder(
              side: BorderSide(
                  color: (borderColour != null) ? borderColour : Colors.white,
                  width: 1.5),
              borderRadius: BorderRadius.circular(10)),
          child: PopupMenuButton(
              shape: ContinuousRectangleBorder(
                  side: BorderSide(
                      color:
                          (borderColour != null) ? borderColour : Colors.white,
                      width: 1.5),
                  borderRadius: BorderRadius.circular(10)),
              color: (popupColour != null) ? popupColour : Colors.black45,
              elevation: 20,
              enabled: true,
              icon: (icon != null)
                  ? icon
                  : Icon(
                      Icons.settings,
                      color: (iconColour != null) ? iconColour : colour(''),
                    ),
              enableFeedback: true,
              onSelected: (value) {
                //defocus();
                onSelection(value.toString());
              },
              itemBuilder: (context) {
                return selectables.map((PopupItem choice) {
                  return PopupMenuItem(
                      value: choice.name,
                      child: Stack(
                        children: <Widget>[
                          Text(
                            choice.name.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.white),
                          ),
                          Text(
                            choice.name.toUpperCase(),
                            style: cxTextStyle(
                                style: 'normal',
                                colour: colour(choice.name),
                                size: 20),
                          ),
                        ],
                      ));
                }).toList();
              })));
}

SizedBox colourPopUpMenu({
  required Function(String) onSelection,
  required List<PopupItem> selectables,
  String? text,
  TextStyle? textStyle,
  Color? buttonColour,
  Icon? icon,
  Color? iconColour,
  backgroundColour,
  borderColour,
  popupColour,
  double? height,
  width,
  fontSize,
}) {
  return SizedBox(
      height: (height != null) ? height : 50,
      width: (width != null) ? width : 50,
      child: Card(
          color: (backgroundColour != null) ? backgroundColour : Colors.black45,
          semanticContainer: true,
          shape: ContinuousRectangleBorder(
              side: BorderSide(
                  color: (borderColour != null) ? borderColour : Colors.white,
                  width: 1.5),
              borderRadius: BorderRadius.circular(10)),
          child: PopupMenuButton(
              shape: ContinuousRectangleBorder(
                  side: const BorderSide(color: Colors.white, width: 1.5),
                  borderRadius: BorderRadius.circular(10)),
              color: (popupColour != null) ? popupColour : Colors.black45,
              enabled: true,
              icon: (icon != null)
                  ? icon
                  : Icon(
                      Icons.settings,
                      color: (iconColour != null) ? iconColour : colour(''),
                    ),
              enableFeedback: true,
              onSelected: (value) {
                //defocus();
                onSelection(value.toString());
              },
              itemBuilder: (context) {
                return selectables.map((PopupItem choice) {
                  return PopupMenuItem(
                      value: choice.name,
                      child: Card(
                          color: (backgroundColour != null)
                              ? backgroundColour
                              : Colors.black45,
                          shape: ContinuousRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Card(
                                    color: (backgroundColour != null)
                                        ? colour(choice.name)
                                        : Colors.black45,
                                    shape: ContinuousRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                Expanded(
                                    child: Text(choice.name.toUpperCase(),
                                        style: cxTextStyle())),
                              ]))
                      /* Stack(
                        children: <Widget>[
                          Text(
                            choice.name.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.white),
                          ),
                          Text(
                            choice.name.toUpperCase(),
                            style: cxTextStyle(
                                style: 'normal',
                                colour: colour(choice.name),
                                size: 20),
                          ),
                        ],
                      )*/
                      );
                }).toList();
              })));
}

class FAB extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon? icon;
  final String? text;
  final TextStyle? style;
  final Color? foreground, background;

  // ignore: use_key_in_widget_constructors
  const FAB(
      {required this.onPressed,
      this.icon,
      this.text,
      this.style,
      this.foreground,
      this.background});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: UniqueKey(),
      onPressed: () {
        // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CALLBACK BUTTON HERE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        defocus();
        onPressed();
      },
      icon: icon,
      label: Text((text != null) ? text! : 'Test',
          style: (style != null)
              ? style
              : cxTextStyle(colour: colour(''), size: 16)),
      foregroundColor: (foreground != null) ? foreground : colour(''),
      backgroundColor: (background != null) ? background : colour('sel'),
    );
  }
}

TextButton cxTextButton({
  required VoidCallback onPressed,
  String? text,
  TextStyle? textStyle,
  Color? buttonColour,
}) {
  return TextButton(
    onPressed: () {
      // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CALLBACK BUTTON HERE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      defocus();
      onPressed();
    },
    //icon: icon,
    child: Text((text != null) ? text : '',
        style: (textStyle != null)
            ? textStyle
            : cxTextStyle(colour: colour(''), size: 16)),
    style: ButtonStyle(
        backgroundColor: (buttonColour != null)
            ? MaterialStateProperty.all<Color>(buttonColour)
            : MaterialStateProperty.all<Color>(Colors.grey)),
  );
}

SizedBox cxIconButton({
  required VoidCallback onPressed,
  Icon? icon,
  Color? iconColour,
  Color? backgroundColour,
  Color? borderColour,
  double? height,
  double? width,
  double? iconSize,
}) {
  return SizedBox(
      height: (height != null) ? height : 50,
      width: (width != null) ? width : 50,
      child: Card(
        color: (backgroundColour != null) ? backgroundColour : Colors.black45,
        shape: (icon != null)
            ? ContinuousRectangleBorder(
                side: BorderSide(
                    color: (borderColour != null) ? borderColour : Colors.white,
                    width: 1.5),
                borderRadius: BorderRadius.circular(10))
            : null,
        child: IconButton(
          enableFeedback: true,
          onPressed: () {
            // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CALLBACK BUTTON HERE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            defocus();
            onPressed();
          },
          icon: (icon != null) ? icon : const Icon(null),
          color: (iconColour != null) ? iconColour : Colors.black45,
          iconSize: (iconSize != null) ? iconSize : 24,
        ),
      ));
}

void debugToast(context) {
  disguisedToast(context: context, message: "TEST");
}

Flushbar disguisedToast(
    {required BuildContext context,
    bool? dismissible,
    String? title,
    TextStyle? titleStyle,
    required String message,
    TextStyle? messageStyle,
    Color? msgColor,
    double? msgSize,
    Color? bgcolour,
    int? secDur,
    VoidCallback? atEnd,
    String? buttonName,
    Color? buttonColour,
    TextStyle? buttonTextStyle,
    Function()? callback,
    Function()? onDismiss,
    bool? closeAfter}) {
  late Flushbar flushbar;
  return flushbar = Flushbar(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(15),
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    backgroundColor: (bgcolour != null) ? bgcolour : Colors.black87,
    mainButton: (callback != null)
        ? TextButton(
            child: Text(
              (buttonName != null) ? buttonName : ' ',
              style:
                  (buttonTextStyle != null) ? buttonTextStyle : cxTextStyle(),
            ),
            style: ButtonStyle(
                backgroundColor: (buttonColour != null)
                    ? MaterialStateProperty.all<Color>(buttonColour)
                    : MaterialStateProperty.all<Color>(Colors.grey)),
            onPressed: () {
              if (closeAfter == null || closeAfter == true) {
                flushbar.dismiss(true);
              }
              callback();
            },
          )
        : null,
    duration: (secDur == null)
        ? const Duration(seconds: 3)
        : (secDur == 0)
            ? null
            : Duration(seconds: secDur),
    isDismissible: (dismissible != null) ? dismissible : true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastOutSlowIn,
    onStatusChanged: (status) {
      if ((status == FlushbarStatus.DISMISSED) && (onDismiss != null)) {
        onDismiss();
      }
    },
    titleText: (title != null)
        ? Text(
            title,
            style: (titleStyle != null)
                ? titleStyle
                : cxTextStyle(style: 'normal'),
          )
        : null,
    messageText: Text(
      message,
      style:
          (messageStyle != null) ? messageStyle : cxTextStyle(style: 'normal'),
    ),
  )..show(context);
}

Flushbar disguisedPrompt(
    {required BuildContext context,
    bool? dismissible,
    String? title,
    TextStyle? titleStyle,
    required String message,
    TextStyle? messageStyle,
    Color? bgcolour,
    int? secDur,
    VoidCallback? atEnd,
    String? button1Name,
    Color? button1Colour,
    Color? button1TextColour,
    String? button2Name,
    Color? button2Colour,
    Color? button2TextColour,
    Function()? button1Callback,
    Function()? button2Callback,
    Function()? onDismiss,
    bool? closeAfter}) {
  late Flushbar flushbar;

  return flushbar = Flushbar(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(15),
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    backgroundColor: (bgcolour != null) ? bgcolour : Colors.black87,
    mainButton: Row(
      children: [
        TextButton(
            onPressed: (button1Callback != null)
                ? () {
                    if (closeAfter == null || closeAfter == true) {
                      flushbar.dismiss(true);
                    }
                    button1Callback();
                  }
                : null,
            child: Text(
              (button1Name != null) ? button1Name : 'BUTTON',
              style: cxTextStyle(colour: button1TextColour),
            ),
            style: ButtonStyle(
                backgroundColor: (button1Colour != null)
                    ? MaterialStateProperty.all<Color>(button1Colour)
                    : MaterialStateProperty.all<Color>(Colors.grey))),
        vfill(12),
        TextButton(
            onPressed: (button2Callback != null)
                ? () {
                    if (closeAfter == null || closeAfter == true) {
                      flushbar.dismiss(true);
                    }
                    button2Callback();
                  }
                : null,
            child: Text(
              (button2Name != null) ? button2Name : 'BUTTON',
              style: cxTextStyle(colour: button2TextColour),
            ),
            style: ButtonStyle(
                backgroundColor: (button2Colour != null)
                    ? MaterialStateProperty.all<Color>(button2Colour)
                    : MaterialStateProperty.all<Color>(Colors.grey))),
      ],
    ),
    duration: (secDur == null)
        ? const Duration(seconds: 3)
        : (secDur == 0)
            ? null
            : Duration(seconds: secDur),
    isDismissible: (dismissible != null) ? dismissible : true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastOutSlowIn,
    onStatusChanged: (status) async {
      if ((status == FlushbarStatus.DISMISSED) && (onDismiss != null)) {
        onDismiss();
      }
    },
    titleText: (title != null)
        ? Text(
            title,
            style: (titleStyle != null)
                ? titleStyle
                : cxTextStyle(style: 'normal'),
          )
        : null,
    messageText: Text(
      message,
      style:
          (messageStyle != null) ? messageStyle : cxTextStyle(style: 'normal'),
    ),
  )..show(context);
}

Flushbar tripleDisguises(
    {required BuildContext context,
    bool? dismissible,
    String? title,
    TextStyle? titleStyle,
    required String message,
    TextStyle? messageStyle,
    Color? bgcolour,
    int? secDur,
    VoidCallback? atEnd,
    String? button1Name,
    Color? button1Colour,
    Color? button1TextColour,
    String? button2Name,
    Color? button2Colour,
    Color? button2TextColour,
    String? button3Name,
    Color? button3Colour,
    Color? button3TextColour,
    Function()? button1Callback,
    Function()? button2Callback,
    Function()? button3Callback,
    Function()? onDismiss,
    bool? closeAfter}) {
  late Flushbar flushbar;

  return flushbar = Flushbar(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(15),
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    backgroundColor: (bgcolour != null) ? bgcolour : Colors.black87,
    mainButton: Row(
      children: [
        TextButton(
            onPressed: (button1Callback != null)
                ? () {
                    if (closeAfter == null || closeAfter == true) {
                      flushbar.dismiss(true);
                    }
                    button1Callback();
                  }
                : null,
            child: Text(
              (button1Name != null) ? button1Name : 'BUTTON',
              style: cxTextStyle(colour: button1TextColour),
            ),
            style: ButtonStyle(
                backgroundColor: (button1Colour != null)
                    ? MaterialStateProperty.all<Color>(button1Colour)
                    : MaterialStateProperty.all<Color>(Colors.grey))),
        vfill(12),
        TextButton(
            onPressed: (button2Callback != null)
                ? () {
                    if (closeAfter == null || closeAfter == true) {
                      flushbar.dismiss(true);
                    }
                    button2Callback();
                  }
                : null,
            child: Text(
              (button2Name != null) ? button2Name : 'BUTTON',
              style: cxTextStyle(colour: button2TextColour),
            ),
            style: ButtonStyle(
                backgroundColor: (button2Colour != null)
                    ? MaterialStateProperty.all<Color>(button2Colour)
                    : MaterialStateProperty.all<Color>(Colors.grey))),
        vfill(12),
        TextButton(
            onPressed: (button3Callback != null)
                ? () {
                    if (closeAfter == null || closeAfter == true) {
                      flushbar.dismiss(true);
                    }
                    button3Callback();
                  }
                : null,
            child: Text(
              (button3Name != null) ? button3Name : 'BUTTON',
              style: cxTextStyle(colour: button3TextColour),
            ),
            style: ButtonStyle(
                backgroundColor: (button3Colour != null)
                    ? MaterialStateProperty.all<Color>(button3Colour)
                    : MaterialStateProperty.all<Color>(Colors.grey))),
      ],
    ),
    duration: (secDur == null)
        ? const Duration(seconds: 3)
        : (secDur == 0)
            ? null
            : Duration(seconds: secDur),
    isDismissible: (dismissible != null) ? dismissible : true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastOutSlowIn,
    onStatusChanged: (status) async {
      if ((status == FlushbarStatus.DISMISSED) && (onDismiss != null)) {
        onDismiss();
      }
    },
    titleText: (title != null)
        ? Text(
            title,
            style: (titleStyle != null)
                ? titleStyle
                : cxTextStyle(style: 'normal'),
          )
        : null,
    messageText: Text(
      message,
      style:
          (messageStyle != null) ? messageStyle : cxTextStyle(style: 'normal'),
    ),
  )..show(context);
}
// BUILD A CLASS WITH DISGUISED TOAST AND METHODS COMBINED AND VARIABLE ASPECTS CUSTOMIZABLE

/*
double rng(double min, double max) {
  final rng = new Random();
  final double rex = max - min;
  return min + rng.nextInt(rex);
}*/

int rng(int? min, int max) {
  final rng = Random();
  min ??= 0;
  final int rex = max - min;
  return min + rng.nextInt(rex);
}

Widget cxMoveWindow() {
  return MoveWindow();
}

/* bool checkPassword(String plainPassword) {
  return new DBCrypt().checkpw(plainPassword,
      "\$2b\$10\$/N6h1FyS267XiEoDS7bUzeIvmtI.N0GHg5KWP..cOidccJNvR0W6u");
}

String encryptPassword(String password) {
  return new DBCrypt().hashpw(password, new DBCrypt().gensalt());
}

void cryptoEncryptPassword(String password) {
  var key = utf8.encode('p@ssw0rd');
  var bytes = utf8.encode("foobar");

  var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
  var digest = hmacSha256.convert(bytes);

  print("HMAC digest as bytes: ${digest.bytes}");
  print("HMAC digest as hex string: $digest");

/*var cipher = crypto.createCipher(algorithm, key);  
var encrypted = cipher.update(text, 'utf8', 'hex') + cipher.final('hex');
var decipher = crypto.createDecipher(algorithm, key);
var decrypted = decipher.update(encrypted, 'hex', 'utf8') + decipher.final('utf8');*/
}*/

/*encrypt_test(String data) {
  //final data = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = encrypt.Key.fromUtf8('iQKAIzLzObCn522aw92EQB9EZECKAITC');
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  final encrypted = encrypter.encrypt(data, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print(encrypted.base64);
}*/

/*class EncrypData implements IEncrypData {
  late String Key=new Buffer(key,'hex';


  @override
  String crypteFile(String data) {
    final encrypter = Encrypter(AES(key, padding: null));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  @override
  String decryptFile(String data) {
    final encrypter = Encrypter(AES(key, padding: null));
    final decrypted = encrypter.decrypt(Encrypted.from64(data), iv: iv);
    return decrypted;
  }
}*/

/*  THIS DELAY ISN'T WORKING AS A METHOD BUT WORKS IF PUT IN CODE AS IT, NO PASS
void delay(int dur) async {
  await Future.delayed(Duration(seconds: dur), () {});
}*/

/* void _select(String choice) {
    setState(() {
      _selectedChoices = choice;
    });
    //print("Onstart: " + target.toString());
    switch (_selectedChoices) {
      case 'Log-in':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        break;
      case 'Log-out':
        print("Log-out OTW");
        break;
      default:
        print(_selectedChoices);
        _selectedChoices = "none";
        print(_selectedChoices);d
        target = -1;
    }
  }*/
