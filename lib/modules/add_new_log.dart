import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_omega_app_v2/models/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';

import '../dev.dart';

class CreateNewLog extends StatefulWidget {
  const CreateNewLog({Key? key}) : super(key: key);

  @override
  _CreateNewLogState createState() => _CreateNewLogState();
}

class _CreateNewLogState extends State<CreateNewLog> {
  int key = 0, increments = 0, listSize = 1, _count = 1;
  String stringBuffer = '';

  final titleCtrlr = TextEditingController();
  final tagsCtrlr = TextEditingController();
  final authorCtrlr = TextEditingController();

  List<FocusNode> nodes = <FocusNode>[FocusNode()];

  List<TextEditingController> contentsCtrlr = <TextEditingController>[
    TextEditingController()
  ];

  late Log newLog;
  late SharedPreferences tokenStore;

  Future<int> uploadLog(
      String title, String tags, List content, String author) async {
    String retrievedToken = '';
    disguisedToast(
        context: context,
        title: 'Uploading Log: ',
        titleStyle: cxTextStyle(
          style: 'bold',
          colour: colour('blue'),
        ),
        message: 'Title: ' + title + '\n Tags: ' + tags,
        messageStyle: cxTextStyle(size: 15),
        secDur: 2);
    await prefSetup().then((value) => {retrievedToken = value!});
    final response = await http.post(
      Uri.parse('https://nexus-omega.herokuapp.com/new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + retrievedToken
      },
      body: jsonEncode({
        'title': title,
        'tags': tags,
        'content': content,
        'author': author,
      }),
    );
    if (response.statusCode == 200) {
      // >>>>>>>>>>>>>>>>>>>>>>>>>>>> RETURN OR REDO PROMPT <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      flush = disguisedPrompt(
          dismissible: false,
          secDur: 0,
          context: context,
          title: "Successfully Added",
          titleStyle: cxTextStyle(style: 'bold'),
          message: "Would you like to add another?",
          messageStyle: cxTextStyle(size: 14),
          button1Name: 'Yes',
          button1Colour: colour('dgreen'),
          button1Callback: () async {
            flush.dismiss(true);
            resetAllFields();
          },
          button2Name: 'No',
          button2Colour: colour('red'),
          button2Callback: () async {
            flush.dismiss(true);
            //s await Future.delayed(Duration(seconds: 2), () {});
            Navigator.pop(context, response.statusCode);
          });
    } else {
      disguisedToast(
          context: context,
          message: 'ERROR ' + response.statusCode.toString(),
          messageStyle: cxTextStyle(style: 'bold', colour: colour('red')));
    }
    return (response.statusCode);
  }

  Future<String?> prefSetup() async {
    tokenStore = await SharedPreferences.getInstance();
    return tokenStore.getString('token');
  }

  void saveLog() async {
    bool emptyDetect = false;
    List<String> listedContent = <String>[];
    for (int i = 0; i < _count; i++) {
      listedContent.add(contentsCtrlr[i].text);
      if (contentsCtrlr[i].text.isEmpty) {
        emptyDetect = true;
      }
    }
    setState(() {
      newLog = Log(titleCtrlr.text, tagsCtrlr.text,
          listedContent.reversed.toList(), authorCtrlr.text);
    });
    if (newLog.title.isEmpty || newLog.tags.isEmpty) {
      emptyDetect = true;
    }

    if (!emptyDetect) {
      await uploadLog(newLog.title, newLog.tags,
          listedContent.reversed.toList(), newLog.author);
    } else {
      disguisedToast(
        context: context,
        title: 'Warning!',
        titleStyle: cxTextStyle(style: 'bold', colour: colour('lred')),
        message: 'Please fill all empty fields',
        messageStyle: cxTextStyle(colour: colour('')),
      );
      emptyDetect = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _count = 1;
    nodes.insert(0, FocusNode());
  }

  resetAllFields() {
    setState(() {
      key = 0;
      increments = 0;
      listSize = 1;
      _count = 1;
      titleCtrlr.clear();
      tagsCtrlr.clear();
      contentsCtrlr.clear();
      authorCtrlr.clear();
      contentsCtrlr = <TextEditingController>[TextEditingController()];
    });
  }

  @override
  void dispose() {
    titleCtrlr.dispose();
    tagsCtrlr.dispose();
    super.dispose();
  }

  late Flushbar flush;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colour('black'),
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: cxMoveWindow(),
        title: cText(text: "New Log Entry", colour: colour('')),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              resetAllFields();
            },
          )
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // >>>>>>>>>>>>>>>>>>>>>>>>>>>> ENTRY FIELDS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
              ctrlrField(
                  context: context,
                  fieldPrompt: "Title",
                  ctrlrID: titleCtrlr,
                  defaultColor: colour(''),
                  selectedColor: colour('sel'),
                  errorColor: Colors.red,
                  next: true,
                  autoFocus: true),
              hfill(10),
              ctrlrField(
                  context: context,
                  fieldPrompt: "Author",
                  ctrlrID: authorCtrlr,
                  defaultColor: colour(''),
                  selectedColor: colour('sel'),
                  errorColor: Colors.red,
                  next: true,
                  autoFocus: false),
              hfill(10),
              ctrlrField(
                  context: context,
                  fieldPrompt: "Tags",
                  ctrlrID: tagsCtrlr,
                  defaultColor: colour(''),
                  selectedColor: colour('sel'),
                  errorColor: Colors.red,
                  next: true,
                  autoFocus: true),
              hfill(10),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(bottom: 8, left: 8),
                child: Text("#s: $_count",
                    style: cxTextStyle(
                        style: 'italic', colour: Colors.grey, size: 12)),
              ),
              hfill(5),
              Flexible(
                child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: _count,
                    itemBuilder: (context, index) {
                      return _contentInput(index, context);
                    }),
              ),
              hfill(45),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FAB(
            onPressed: () {
              // >>>>>>>>>>>>>>>>>>>>>>>>>>>> ADD BUTTON <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
              _incContentFields();
            },
            icon: const Icon(Icons.add),
            text: "Add",
            foreground: colour(''),
            background: colour('dblue'),
          ),
          vfill(12),
          FAB(
            onPressed: () {
              // >>>>>>>>>>>>>>>>>>>>>>>>>>>> SAVE BUTTON <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
              saveLog();
            },
            icon: const Icon(Icons.save),
            text: "Save",
            background: colour('dblue'),
          ),
        ],
      ),
    );
  }

  _incContentFields() {
    setState(() {
      _count++;
      increments++;
      listSize++;
      contentsCtrlr.insert(0, TextEditingController());
      //nodes.insert(_count, FocusNode());
    });
  }

  _contentInput(int index, context) {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          cxIconButton(
            onPressed: () {
              //FocusManager.instance.primaryFocus?.unfocus();
              if (_count != 1) {
                setState(() {
                  _count--;
                  increments--;
                  listSize--;
                  contentsCtrlr.removeAt(index);
                });
              }
            },
            icon: (_count != 1) ? const Icon(Icons.remove) : null,
            iconColour: colour(''),
          ),
          Column(children: <Widget>[
            cxIconButton(
              onPressed: () {
                setState(() {
                  if (index < contentsCtrlr.length - 1) {
                    //  WORKING TEXT SWAP
                    stringBuffer = contentsCtrlr[index].text;
                    contentsCtrlr[index].text = contentsCtrlr[index + 1].text;
                    contentsCtrlr[index + 1].text = stringBuffer;
                  }
                });
              },
              height: 35,
              width: 35,
              iconSize: 11,
              icon: ((index == 0) && (index == contentsCtrlr.length - 1))
                  ? null
                  : (index == contentsCtrlr.length - 1)
                      ? const Icon(Icons.not_interested)
                      : const Icon(Icons.arrow_upward),
              iconColour: colour(''),
            ),
            cxIconButton(
              onPressed: () {
                setState(() {
                  if (index > 0) {
                    //  WORKING TEXT SWAP
                    stringBuffer = contentsCtrlr[index].text;
                    contentsCtrlr[index].text = contentsCtrlr[index - 1].text;
                    contentsCtrlr[index - 1].text = stringBuffer;
                  } else {}
                });
              },
              height: 35,
              width: 35,
              iconSize: 11,
              icon: ((index == 0) && (index == contentsCtrlr.length - 1))
                  ? null
                  : (index == 0)
                      ? const Icon(Icons.not_interested)
                      : const Icon(Icons.arrow_downward),
              iconColour: colour(''),
            ),
          ]),
          Expanded(
            child: ctrlrField(
              context: context,
              //node: nodes[0],
              fieldPrompt: "Par #" + (_count - index).toString(),
              ctrlrID: contentsCtrlr[index],
              defaultColor: colour(''),
              selectedColor: colour('sel'),
              errorColor: Colors.red,
              next: true,
              autoFocus: false,
              inputType: TextInputType.multiline,
              maxLines: null,
              onSubmit: () => {
                if (Platform.isWindows)
                  {
                    contentsCtrlr[index].text =
                        backSpaceString(contentsCtrlr[index].text)
                  },
                if (index == 0)
                  {
                    _incContentFields(),
                  }
              },
            ),
          ),
        ],
      ),
      hfill(12),
    ]);
  }
}
