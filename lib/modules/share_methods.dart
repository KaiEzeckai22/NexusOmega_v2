import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_omega_app_v2/models/log.dart';
import 'package:share_plus/share_plus.dart';
import 'package:another_flushbar/flushbar.dart';

import '../dev.dart';

late Flushbar flush;

void exportLogJSON(BuildContext context, Log any) {
  //final RenderBox box = context.findRenderObject();
  String text = any.toJson().toString();
  if (Platform.isWindows) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      disguisedToast(context: context, message: 'Copied to Clipboard');
    });
  } else {
    Share.share(text, subject: any.title);
  }
}

void shareLog(BuildContext context, Log any) {
  //final RenderBox box = context.findRenderObject();
  String text = 'Title: ' + any.title + '\nAuthor: ' + any.author;
  int contentsSize = any.content.length;
  for (int i = 0; i < contentsSize; i++) {
    text = text + '\n\n\t' + any.content[i];
  }
  text = text + '\n\nTags: ' + any.tags;
  if (Platform.isWindows) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      disguisedToast(context: context, message: 'Copied to Clipboard');
    });
  } else {
    Share.share(
      any.toJson().toString(),
      subject: any.title + '-JSON',
    );
  }
}
