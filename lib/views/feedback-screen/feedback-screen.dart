import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/forms-components/form-text-field-component.dart';
import '../../components/icon-components/icon-generic.dart';
import '../../components/information-box-component/information-box-component.dart';
import '../../components/text-components/text-generic.dart';
import '../../constants.dart';
import '../../generated/l10n.dart';

class FeedBackScreen extends StatefulWidget {
  static const String id = 'feedback_screen';

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  String dropDownValue;

  FocusScopeNode _focusScopeNode = FocusScopeNode();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  void dispose() {
    _focusScopeNode.dispose();
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _handleSubmitted(String value) {
    _focusScopeNode.nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);
    if (dropDownValue == null) {
      dropDownValue = translate.feedback_drop_down_value_feature_suggestion;
    }
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: IconGeneric(
            androidIcon: Icons.arrow_back,
            iOSIcon: CupertinoIcons.back,
            toolTip: translate.tooltip_previous_screen,
          ),
        ),
        title: TextGeneric(
          text: translate.feedback_screen_title,
          fontSize: kSectionTitleSize,
        ),
        actions: <Widget>[
          Platform.isAndroid
              ? IconButton(
                  icon: IconGeneric(
                    androidIcon: Icons.send,
                    semanticLabel: translate.send,
                    toolTip: translate.send,
                  ),
                  onPressed: () {},
                )
              : FlatButton(
                  onPressed: () {},
                  child: TextGeneric(text: translate.send),
                ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: FocusScope(
          node: _focusScopeNode,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InformationBox(
                  title: translate.feedback_information_box_title,
                  subTitle: translate.feedback_information_box_subtitle,
                ),
                FormTextField(
                  labelText: translate.feedback_email_label_text,
                  hintText: translate.feedback_email_hint_text,
                  handleSubmitted: _handleSubmitted,
                  controller: _controller1,
                  textInputAction: TextInputAction.next,
                  androidIcon: Icons.email,
                  iosIcon: CupertinoIcons.mail_solid,
                  minLines: 1,
                  maxLines: 1,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 16,
                ),
                DropdownButton(
                  value: dropDownValue,
                  items: <String>[
                    translate.feedback_drop_down_value_feature_suggestion,
                    translate.feedback_drop_down_value_problem
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  icon: IconGeneric(
                    androidIcon: Icons.arrow_drop_down,
                    iOSIcon: CupertinoIcons.down_arrow,
                  ),
                  isExpanded: true,
                  elevation: 16,
                  underline: Container(
                    height: 1,
                    color: Theme.of(context).buttonColor,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropDownValue = newValue;
                    });
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                FormTextField(
                  labelText: dropDownValue,
                  hintText: dropDownValue ==
                          translate.feedback_drop_down_value_problem
                      ? translate.feedback_describe_problem
                      : translate.feedback_describe_feature,
                  controller: _controller2,
                  textInputAction: TextInputAction.done,
                  androidIcon: Icons.feedback,
                  iosIcon: CupertinoIcons.conversation_bubble,
                  minLines: 1,
                  maxLines: 10,
                  textInputType: TextInputType.multiline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
