import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:nexus_omega_app/modules/dialogues.dart';
// import 'package:nexus_omega_app/modules/logs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';

import 'dev.dart';
import 'modules/dialogues.dart';
import 'modules/login.dart';
import 'modules/logs.dart';
// import 'login.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late SharedPreferences tokenStore;
  List<String> mainOptions = [
    'Logs',
    'Dialogues',
    // 'Nuke',
    // 'PJP',
    // 'Projects',
    // 'Casual Tragedy',
    // 'More',
    'nukeTest',
  ];
  String debug = "";
  int numdeBug = 0;
  TextEditingController searchCtrlr = TextEditingController();
  bool promptLocked = false;
  String searchString = "";
  //

  List<PopupItem> menu = [
    PopupItem(1, "Log-in"),
    PopupItem(2, "Log-out"),
    PopupItem(3, "Exit"),
    //PopupItem(4, "DevTest-sb"),
    //PopupItem(5, "DevTest-newGet"),
    PopupItem(
        0, "nukeTest"), // <<< UNCOMMENT THIS TO ACTIVATE NUKE TEST AREA/BUTTON
  ];
  String _selectedChoices = "none";
  void _select(String choice) {
    setState(() {
      _selectedChoices = choice;
    });
    switch (_selectedChoices) {
      case 'Log-in':
        loginTrigger();
        break;
      case 'Log-out':
        tokenStore.setString('token', '');
        disguisedToast(
            context: context,
            message: 'Logged out',
            messageStyle: cxTextStyle(style: 'bold', colour: colour('red')));
        break;
      case 'Exit':
        disguisedToast(
            context: context, message: 'Closing App', onDismiss: () => exit(0));
        break;
      case 'nukeTest':
        cxColourList.namesToString();
        break;
      default:
        _selectedChoices = 'none';
    }
  }

  late Flushbar flush;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colour('black'),
      appBar: AppBar(
        backgroundColor: colour('dblue'),
        flexibleSpace: cxMoveWindow(),
        title: cText(text: "Main Menu "),
        actions: [
          SelectionMenu(
            selectables: menu,
            onSelection: (String value) => setState(() {
              _select(value);
              FocusManager.instance.primaryFocus?.unfocus();
            }),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // SEARCH BAR SHOULD BE HERE
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              cText(text: " LOG-IN "),
              cxIconButton(
                  onPressed: () {
                    loginTrigger();
                  },
                  icon: const Icon(Icons.login),
                  borderColour: colour('grey'),
                  iconColour: colour('blue')),
              vfill(3),
            ],
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.only(bottom: 60),
                height: double.infinity,
                width: double.infinity,
                color: Colors.black,
                child:
                    FutureBuilder<List<String>>(builder: (context, snapshot) {
                  return SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 100),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: ListView.builder(
                          key: UniqueKey(),
                          padding: const EdgeInsetsDirectional.all(10), // MARK
                          itemCount: mainOptions.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                // // >>>>>>>>>>>>>>>>>>>>>>>>>>>> PUSH TO NEXT UPDATE SCREEN <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                                nextMenu(index);
                              },
                              child: Card(
                                color: Colors.black,
                                shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: colour('blue'), width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(mainOptions[index],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
                })),
          ),
        ],
      ),
    );
  }

  loginTrigger() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  nextMenu(int index) {
    disguisedToast(
        context: context,
        title: "Redirecting to",
        titleStyle: cxTextStyle(style: 'bold'),
        message: '  ' + mainOptions[index],
        messageStyle: cxTextStyle());
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LogList()));
        //disguisedToast(context: context, message: mainOptions[index]);
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DialogueList()));
        //disguisedToast(context: context, message: mainOptions[index]);
        break;
      case 2:

        //disguisedToast(context: context, message: mainOptions[index]);
        break;
      default:
        break;
    }
  }
}
