import 'package:flutter/material.dart';

class LoadingTimePreference extends StatelessWidget {
  const LoadingTimePreference({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(),
    );
  }
}
