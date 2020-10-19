import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'write_on.dart';

class Arguments {
  final String title;
  final String note;
  final Color color;
  final String key;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final WriteOn box;
  final BuildContext context;

  Arguments({
    this.title,
    this.note,
    this.color,
    this.key,
    this.scaffoldKey,
    this.box,
    this.context,
  });
}
