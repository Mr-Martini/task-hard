// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `P Notes`
  String get app_name {
    return Intl.message(
      'P Notes',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Feature suggestion`
  String get feedback_drop_down_value_feature_suggestion {
    return Intl.message(
      'Feature suggestion',
      name: 'feedback_drop_down_value_feature_suggestion',
      desc: '',
      args: [],
    );
  }

  /// `Problem`
  String get feedback_drop_down_value_problem {
    return Intl.message(
      'Problem',
      name: 'feedback_drop_down_value_problem',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get tooltip_previous_screen {
    return Intl.message(
      'Back',
      name: 'tooltip_previous_screen',
      desc: '',
      args: [],
    );
  }

  /// `FeedBack`
  String get feedback_screen_title {
    return Intl.message(
      'FeedBack',
      name: 'feedback_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Do not include any personal information`
  String get feedback_information_box_title {
    return Intl.message(
      'Do not include any personal information',
      name: 'feedback_information_box_title',
      desc: '',
      args: [],
    );
  }

  /// `Such as email, name, age...`
  String get feedback_information_box_subtitle {
    return Intl.message(
      'Such as email, name, age...',
      name: 'feedback_information_box_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email (optional)`
  String get feedback_email_label_text {
    return Intl.message(
      'Email (optional)',
      name: 'feedback_email_label_text',
      desc: '',
      args: [],
    );
  }

  /// `example@email.com`
  String get feedback_email_hint_text {
    return Intl.message(
      'example@email.com',
      name: 'feedback_email_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `Describe your problem`
  String get feedback_describe_problem {
    return Intl.message(
      'Describe your problem',
      name: 'feedback_describe_problem',
      desc: '',
      args: [],
    );
  }

  /// `Describe your suggestion`
  String get feedback_describe_feature {
    return Intl.message(
      'Describe your suggestion',
      name: 'feedback_describe_feature',
      desc: '',
      args: [],
    );
  }

  /// `send feedback`
  String get feedback_send_feedback_semantic_label {
    return Intl.message(
      'send feedback',
      name: 'feedback_send_feedback_semantic_label',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get empty_notes {
    return Intl.message(
      'Empty',
      name: 'empty_notes',
      desc: '',
      args: [],
    );
  }

  /// `Create note`
  String get tooltip_create_note {
    return Intl.message(
      'Create note',
      name: 'tooltip_create_note',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get tooltip_home_screen {
    return Intl.message(
      'Back',
      name: 'tooltip_home_screen',
      desc: '',
      args: [],
    );
  }

  /// `New note`
  String get new_note {
    return Intl.message(
      'New note',
      name: 'new_note',
      desc: '',
      args: [],
    );
  }

  /// `Edit note`
  String get edit_note {
    return Intl.message(
      'Edit note',
      name: 'edit_note',
      desc: '',
      args: [],
    );
  }

  /// `note`
  String get note_minu {
    return Intl.message(
      'note',
      name: 'note_minu',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get note_title {
    return Intl.message(
      'Title',
      name: 'note_title',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note_note {
    return Intl.message(
      'Note',
      name: 'note_note',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Voice recording`
  String get voice_recording {
    return Intl.message(
      'Voice recording',
      name: 'voice_recording',
      desc: '',
      args: [],
    );
  }

  /// `Attach a voice record`
  String get attach_voice_record {
    return Intl.message(
      'Attach a voice record',
      name: 'attach_voice_record',
      desc: '',
      args: [],
    );
  }

  /// `Attach a category`
  String get attach_a_category {
    return Intl.message(
      'Attach a category',
      name: 'attach_a_category',
      desc: '',
      args: [],
    );
  }

  /// `E.g English class tomorrow`
  String get category_example {
    return Intl.message(
      'E.g English class tomorrow',
      name: 'category_example',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Add a reminder`
  String get add_a_reminder {
    return Intl.message(
      'Add a reminder',
      name: 'add_a_reminder',
      desc: '',
      args: [],
    );
  }

  /// `All day`
  String get all_day {
    return Intl.message(
      'All day',
      name: 'all_day',
      desc: '',
      args: [],
    );
  }

  /// `No repeat`
  String get no_repeat {
    return Intl.message(
      'No repeat',
      name: 'no_repeat',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get Ok {
    return Intl.message(
      'Ok',
      name: 'Ok',
      desc: '',
      args: [],
    );
  }

  /// `Alarm`
  String get alarm {
    return Intl.message(
      'Alarm',
      name: 'alarm',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Search..`
  String get search_hint_text {
    return Intl.message(
      'Search..',
      name: 'search_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Archived`
  String get archived {
    return Intl.message(
      'Archived',
      name: 'archived',
      desc: '',
      args: [],
    );
  }

  /// `Archived notes`
  String get archived_notes {
    return Intl.message(
      'Archived notes',
      name: 'archived_notes',
      desc: '',
      args: [],
    );
  }

  /// `Trash`
  String get trash {
    return Intl.message(
      'Trash',
      name: 'trash',
      desc: '',
      args: [],
    );
  }

  /// `Deleted notes`
  String get deleted_notes {
    return Intl.message(
      'Deleted notes',
      name: 'deleted_notes',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Primary color`
  String get primary_color {
    return Intl.message(
      'Primary color',
      name: 'primary_color',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Change email`
  String get change_email {
    return Intl.message(
      'Change email',
      name: 'change_email',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Change user name`
  String get change_name {
    return Intl.message(
      'Change user name',
      name: 'change_name',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get delete_account {
    return Intl.message(
      'Delete account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `You'll loose all your data`
  String get you_loose_all_data {
    return Intl.message(
      'You\'ll loose all your data',
      name: 'you_loose_all_data',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get sign_in_google {
    return Intl.message(
      'Sign in with Google',
      name: 'sign_in_google',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `You'll loose access to your data if the app is deleted or if you clear the cache`
  String get loose_access_data_cache_delete {
    return Intl.message(
      'You\'ll loose access to your data if the app is deleted or if you clear the cache',
      name: 'loose_access_data_cache_delete',
      desc: '',
      args: [],
    );
  }

  /// `Continue anyway`
  String get continue_anyway {
    return Intl.message(
      'Continue anyway',
      name: 'continue_anyway',
      desc: '',
      args: [],
    );
  }

  /// `Continue without signing in`
  String get continue_without_sign_in {
    return Intl.message(
      'Continue without signing in',
      name: 'continue_without_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Important notification`
  String get important_notification {
    return Intl.message(
      'Important notification',
      name: 'important_notification',
      desc: '',
      args: [],
    );
  }

  /// `Cancel selection`
  String get cancel_selection {
    return Intl.message(
      'Cancel selection',
      name: 'cancel_selection',
      desc: '',
      args: [],
    );
  }

  /// `Delete selected notes?`
  String get delete_selected_notes {
    return Intl.message(
      'Delete selected notes?',
      name: 'delete_selected_notes',
      desc: '',
      args: [],
    );
  }

  /// `Delete selected note?`
  String get delete_selected_note {
    return Intl.message(
      'Delete selected note?',
      name: 'delete_selected_note',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Delete selected items`
  String get deleted_selected_items {
    return Intl.message(
      'Delete selected items',
      name: 'deleted_selected_items',
      desc: '',
      args: [],
    );
  }

  /// `FeedBack`
  String get feedback {
    return Intl.message(
      'FeedBack',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Go to FeedBack screen`
  String get tooltip_go_to_feedback_screen {
    return Intl.message(
      'Go to FeedBack screen',
      name: 'tooltip_go_to_feedback_screen',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Quick actions`
  String get quick_actions {
    return Intl.message(
      'Quick actions',
      name: 'quick_actions',
      desc: '',
      args: [],
    );
  }

  /// `Go to Profile screen`
  String get tooltip_go_to_profile_screen {
    return Intl.message(
      'Go to Profile screen',
      name: 'tooltip_go_to_profile_screen',
      desc: '',
      args: [],
    );
  }

  /// `App settings`
  String get app_settings {
    return Intl.message(
      'App settings',
      name: 'app_settings',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get app_about {
    return Intl.message(
      'About the app',
      name: 'app_about',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get sign_out {
    return Intl.message(
      'Sign out',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Change color`
  String get change_color {
    return Intl.message(
      'Change color',
      name: 'change_color',
      desc: '',
      args: [],
    );
  }

  /// `Important`
  String get important {
    return Intl.message(
      'Important',
      name: 'important',
      desc: '',
      args: [],
    );
  }

  /// `Choose a color`
  String get choose_a_color {
    return Intl.message(
      'Choose a color',
      name: 'choose_a_color',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get select_all {
    return Intl.message(
      'Select all',
      name: 'select_all',
      desc: '',
      args: [],
    );
  }

  /// `Pick a date`
  String get pick_a_date {
    return Intl.message(
      'Pick a date',
      name: 'pick_a_date',
      desc: '',
      args: [],
    );
  }

  /// `Pick a time`
  String get pick_a_time {
    return Intl.message(
      'Pick a time',
      name: 'pick_a_time',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Select a date`
  String get select_a_date {
    return Intl.message(
      'Select a date',
      name: 'select_a_date',
      desc: '',
      args: [],
    );
  }

  /// `Select a time`
  String get select_a_time {
    return Intl.message(
      'Select a time',
      name: 'select_a_time',
      desc: '',
      args: [],
    );
  }

  /// `Eight`
  String get eight {
    return Intl.message(
      'Eight',
      name: 'eight',
      desc: '',
      args: [],
    );
  }

  /// `Twelve`
  String get twelve {
    return Intl.message(
      'Twelve',
      name: 'twelve',
      desc: '',
      args: [],
    );
  }

  /// `Sixteen`
  String get sixteen {
    return Intl.message(
      'Sixteen',
      name: 'sixteen',
      desc: '',
      args: [],
    );
  }

  /// `Twenty`
  String get twenty {
    return Intl.message(
      'Twenty',
      name: 'twenty',
      desc: '',
      args: [],
    );
  }

  /// `Time travel not allowed`
  String get go_back_time {
    return Intl.message(
      'Time travel not allowed',
      name: 'go_back_time',
      desc: '',
      args: [],
    );
  }

  /// `8:00 AM`
  String get eight_am {
    return Intl.message(
      '8:00 AM',
      name: 'eight_am',
      desc: '',
      args: [],
    );
  }

  /// `12:00 AM`
  String get twelve_am {
    return Intl.message(
      '12:00 AM',
      name: 'twelve_am',
      desc: '',
      args: [],
    );
  }

  /// `4:00 PM`
  String get sixteen_pm {
    return Intl.message(
      '4:00 PM',
      name: 'sixteen_pm',
      desc: '',
      args: [],
    );
  }

  /// `8:00 PM`
  String get twenty_pm {
    return Intl.message(
      '8:00 PM',
      name: 'twenty_pm',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get Jan {
    return Intl.message(
      'January',
      name: 'Jan',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get Feb {
    return Intl.message(
      'February',
      name: 'Feb',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get Mar {
    return Intl.message(
      'March',
      name: 'Mar',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get Apr {
    return Intl.message(
      'April',
      name: 'Apr',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get May {
    return Intl.message(
      'May',
      name: 'May',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get Jun {
    return Intl.message(
      'June',
      name: 'Jun',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get Jul {
    return Intl.message(
      'July',
      name: 'Jul',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get Aug {
    return Intl.message(
      'August',
      name: 'Aug',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get Sep {
    return Intl.message(
      'September',
      name: 'Sep',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get Oct {
    return Intl.message(
      'October',
      name: 'Oct',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get Nov {
    return Intl.message(
      'November',
      name: 'Nov',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get Dec {
    return Intl.message(
      'December',
      name: 'Dec',
      desc: '',
      args: [],
    );
  }

  /// `Jan`
  String get jan {
    return Intl.message(
      'Jan',
      name: 'jan',
      desc: '',
      args: [],
    );
  }

  /// `Feb`
  String get feb {
    return Intl.message(
      'Feb',
      name: 'feb',
      desc: '',
      args: [],
    );
  }

  /// `Mar`
  String get mar {
    return Intl.message(
      'Mar',
      name: 'mar',
      desc: '',
      args: [],
    );
  }

  /// `Apr`
  String get apr {
    return Intl.message(
      'Apr',
      name: 'apr',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `Jun`
  String get jun {
    return Intl.message(
      'Jun',
      name: 'jun',
      desc: '',
      args: [],
    );
  }

  /// `Jul`
  String get jul {
    return Intl.message(
      'Jul',
      name: 'jul',
      desc: '',
      args: [],
    );
  }

  /// `Aug`
  String get aug {
    return Intl.message(
      'Aug',
      name: 'aug',
      desc: '',
      args: [],
    );
  }

  /// `Sep`
  String get sep {
    return Intl.message(
      'Sep',
      name: 'sep',
      desc: '',
      args: [],
    );
  }

  /// `Oct`
  String get oct {
    return Intl.message(
      'Oct',
      name: 'oct',
      desc: '',
      args: [],
    );
  }

  /// `Nov`
  String get nov {
    return Intl.message(
      'Nov',
      name: 'nov',
      desc: '',
      args: [],
    );
  }

  /// `Dec`
  String get dec {
    return Intl.message(
      'Dec',
      name: 'dec',
      desc: '',
      args: [],
    );
  }

  /// `Note deleted`
  String get note_deleted {
    return Intl.message(
      'Note deleted',
      name: 'note_deleted',
      desc: '',
      args: [],
    );
  }

  /// `deleted`
  String get deleted {
    return Intl.message(
      'deleted',
      name: 'deleted',
      desc: '',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `More actions`
  String get more_actions {
    return Intl.message(
      'More actions',
      name: 'more_actions',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get info {
    return Intl.message(
      'Details',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Collaborator`
  String get collaborator {
    return Intl.message(
      'Collaborator',
      name: 'collaborator',
      desc: '',
      args: [],
    );
  }

  /// `Personalization`
  String get personalization {
    return Intl.message(
      'Personalization',
      name: 'personalization',
      desc: '',
      args: [],
    );
  }

  /// `Back to settings screen`
  String get back_settings {
    return Intl.message(
      'Back to settings screen',
      name: 'back_settings',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archive_note {
    return Intl.message(
      'Archive',
      name: 'archive_note',
      desc: '',
      args: [],
    );
  }

  /// `Note(s) archived`
  String get note_archived {
    return Intl.message(
      'Note(s) archived',
      name: 'note_archived',
      desc: '',
      args: [],
    );
  }

  /// `Back to archive screen`
  String get back_archive_screen {
    return Intl.message(
      'Back to archive screen',
      name: 'back_archive_screen',
      desc: '',
      args: [],
    );
  }

  /// `Archived`
  String get archives {
    return Intl.message(
      'Archived',
      name: 'archives',
      desc: '',
      args: [],
    );
  }

  /// `Note restored`
  String get note_restore {
    return Intl.message(
      'Note restored',
      name: 'note_restore',
      desc: '',
      args: [],
    );
  }

  /// `Restored`
  String get restored {
    return Intl.message(
      'Restored',
      name: 'restored',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restore {
    return Intl.message(
      'Restore',
      name: 'restore',
      desc: '',
      args: [],
    );
  }

  /// `notes`
  String get notes {
    return Intl.message(
      'notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Restore this note?`
  String get restore_selected_note {
    return Intl.message(
      'Restore this note?',
      name: 'restore_selected_note',
      desc: '',
      args: [],
    );
  }

  /// `Restore everything`
  String get restore_all {
    return Intl.message(
      'Restore everything',
      name: 'restore_all',
      desc: '',
      args: [],
    );
  }

  /// `Restore all notes?`
  String get restore_all_notes_question {
    return Intl.message(
      'Restore all notes?',
      name: 'restore_all_notes_question',
      desc: '',
      args: [],
    );
  }

  /// `There isn't any archived notes`
  String get no_notes_to_restore {
    return Intl.message(
      'There isn\'t any archived notes',
      name: 'no_notes_to_restore',
      desc: '',
      args: [],
    );
  }

  /// `Trash is empty`
  String get empty_trash {
    return Intl.message(
      'Trash is empty',
      name: 'empty_trash',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notes forever?`
  String get perma_delete_question {
    return Intl.message(
      'Delete all notes forever?',
      name: 'perma_delete_question',
      desc: '',
      args: [],
    );
  }

  /// `No archived notes`
  String get no_notes_archived {
    return Intl.message(
      'No archived notes',
      name: 'no_notes_archived',
      desc: '',
      args: [],
    );
  }

  /// `Archived notes will appear here`
  String get notes_your_archive {
    return Intl.message(
      'Archived notes will appear here',
      name: 'notes_your_archive',
      desc: '',
      args: [],
    );
  }

  /// `deleted notes will appear here`
  String get notes_your_delete {
    return Intl.message(
      'deleted notes will appear here',
      name: 'notes_your_delete',
      desc: '',
      args: [],
    );
  }

  /// `Create a note tapping in the floating button`
  String get empty_home_notes {
    return Intl.message(
      'Create a note tapping in the floating button',
      name: 'empty_home_notes',
      desc: '',
      args: [],
    );
  }

  /// `Moved`
  String get moved {
    return Intl.message(
      'Moved',
      name: 'moved',
      desc: '',
      args: [],
    );
  }

  /// `trash`
  String get trashMinu {
    return Intl.message(
      'trash',
      name: 'trashMinu',
      desc: '',
      args: [],
    );
  }

  /// `archive`
  String get archiveMinu {
    return Intl.message(
      'archive',
      name: 'archiveMinu',
      desc: '',
      args: [],
    );
  }

  /// `note(s)`
  String get notePlu {
    return Intl.message(
      'note(s)',
      name: 'notePlu',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message(
      'to',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Unarchive`
  String get unarchive {
    return Intl.message(
      'Unarchive',
      name: 'unarchive',
      desc: '',
      args: [],
    );
  }

  /// `Add person`
  String get add_person {
    return Intl.message(
      'Add person',
      name: 'add_person',
      desc: '',
      args: [],
    );
  }

  /// `Tap the button again to search`
  String get tap_button_search {
    return Intl.message(
      'Tap the button again to search',
      name: 'tap_button_search',
      desc: '',
      args: [],
    );
  }

  /// `Nothing found`
  String get nothing_found {
    return Intl.message(
      'Nothing found',
      name: 'nothing_found',
      desc: '',
      args: [],
    );
  }

  /// `Reminder(s) deleted`
  String get reminders_deleted {
    return Intl.message(
      'Reminder(s) deleted',
      name: 'reminders_deleted',
      desc: '',
      args: [],
    );
  }

  /// `View licenses`
  String get view_licenses {
    return Intl.message(
      'View licenses',
      name: 'view_licenses',
      desc: '',
      args: [],
    );
  }

  /// `Licenses`
  String get licenses {
    return Intl.message(
      'Licenses',
      name: 'licenses',
      desc: '',
      args: [],
    );
  }

  /// `2020 P Notes®\nAll rights reserved`
  String get license_rights {
    return Intl.message(
      '2020 P Notes®\nAll rights reserved',
      name: 'license_rights',
      desc: '',
      args: [],
    );
  }

  /// `Delete note?`
  String get delete_note_question {
    return Intl.message(
      'Delete note?',
      name: 'delete_note_question',
      desc: '',
      args: [],
    );
  }

  /// `Archive note?`
  String get archive_note_question {
    return Intl.message(
      'Archive note?',
      name: 'archive_note_question',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archive {
    return Intl.message(
      'Archive',
      name: 'archive',
      desc: '',
      args: [],
    );
  }

  /// `Create a copy`
  String get create_copy {
    return Intl.message(
      'Create a copy',
      name: 'create_copy',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Copy created`
  String get copy_created {
    return Intl.message(
      'Copy created',
      name: 'copy_created',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `monday`
  String get monday {
    return Intl.message(
      'monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `tuesday`
  String get tuesday {
    return Intl.message(
      'tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `wednesday`
  String get wednesday {
    return Intl.message(
      'wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `thursday`
  String get thursday {
    return Intl.message(
      'thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `friday`
  String get friday {
    return Intl.message(
      'friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `saturday`
  String get saturday {
    return Intl.message(
      'saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `sunday`
  String get sunday {
    return Intl.message(
      'sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Each`
  String get each {
    return Intl.message(
      'Each',
      name: 'each',
      desc: '',
      args: [],
    );
  }

  /// `Staggered`
  String get staggered {
    return Intl.message(
      'Staggered',
      name: 'staggered',
      desc: '',
      args: [],
    );
  }

  /// `Rectangle`
  String get rectangle {
    return Intl.message(
      'Rectangle',
      name: 'rectangle',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get list {
    return Intl.message(
      'List',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `View style`
  String get view_style {
    return Intl.message(
      'View style',
      name: 'view_style',
      desc: '',
      args: [],
    );
  }

  /// `Cannot archive empty note`
  String get cannot_archive_empty_note {
    return Intl.message(
      'Cannot archive empty note',
      name: 'cannot_archive_empty_note',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `Tag`
  String get tag {
    return Intl.message(
      'Tag',
      name: 'tag',
      desc: '',
      args: [],
    );
  }

  /// `Add a tag`
  String get add_a_tag {
    return Intl.message(
      'Add a tag',
      name: 'add_a_tag',
      desc: '',
      args: [],
    );
  }

  /// `Type a tag`
  String get type_a_tag {
    return Intl.message(
      'Type a tag',
      name: 'type_a_tag',
      desc: '',
      args: [],
    );
  }

  /// `Type a new tag`
  String get type_a_new_tag {
    return Intl.message(
      'Type a new tag',
      name: 'type_a_new_tag',
      desc: '',
      args: [],
    );
  }

  /// `Load more`
  String get load_more {
    return Intl.message(
      'Load more',
      name: 'load_more',
      desc: '',
      args: [],
    );
  }

  /// `Date & Time`
  String get date_and_time {
    return Intl.message(
      'Date & Time',
      name: 'date_and_time',
      desc: '',
      args: [],
    );
  }

  /// `Morning`
  String get morning {
    return Intl.message(
      'Morning',
      name: 'morning',
      desc: '',
      args: [],
    );
  }

  /// `Noon`
  String get noon {
    return Intl.message(
      'Noon',
      name: 'noon',
      desc: '',
      args: [],
    );
  }

  /// `Afternoon`
  String get afternoon {
    return Intl.message(
      'Afternoon',
      name: 'afternoon',
      desc: '',
      args: [],
    );
  }

  /// `Night`
  String get night {
    return Intl.message(
      'Night',
      name: 'night',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Automatic`
  String get automatic {
    return Intl.message(
      'Automatic',
      name: 'automatic',
      desc: '',
      args: [],
    );
  }

  /// `Update reminder`
  String get update_reminder {
    return Intl.message(
      'Update reminder',
      name: 'update_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Cannot edit deleted note`
  String get restore_to_edited {
    return Intl.message(
      'Cannot edit deleted note',
      name: 'restore_to_edited',
      desc: '',
      args: [],
    );
  }

  /// `No tags created`
  String get no_tags {
    return Intl.message(
      'No tags created',
      name: 'no_tags',
      desc: '',
      args: [],
    );
  }

  /// `Add a tag`
  String get add_tag {
    return Intl.message(
      'Add a tag',
      name: 'add_tag',
      desc: '',
      args: [],
    );
  }

  /// `E.g: Daily tasks`
  String get tag_example {
    return Intl.message(
      'E.g: Daily tasks',
      name: 'tag_example',
      desc: '',
      args: [],
    );
  }

  /// `Choose a tag`
  String get choose_a_tag {
    return Intl.message(
      'Choose a tag',
      name: 'choose_a_tag',
      desc: '',
      args: [],
    );
  }

  /// `Remove tag`
  String get remove_tag {
    return Intl.message(
      'Remove tag',
      name: 'remove_tag',
      desc: '',
      args: [],
    );
  }

  /// `Update tag`
  String get update_tag {
    return Intl.message(
      'Update tag',
      name: 'update_tag',
      desc: '',
      args: [],
    );
  }

  /// `Edit tag name`
  String get edit_tag_name {
    return Intl.message(
      'Edit tag name',
      name: 'edit_tag_name',
      desc: '',
      args: [],
    );
  }

  /// `This will delete the selected tag(s) from all your notes`
  String get this_will_delete_tag_note {
    return Intl.message(
      'This will delete the selected tag(s) from all your notes',
      name: 'this_will_delete_tag_note',
      desc: '',
      args: [],
    );
  }

  /// `Removed`
  String get removed {
    return Intl.message(
      'Removed',
      name: 'removed',
      desc: '',
      args: [],
    );
  }

  /// `from`
  String get from {
    return Intl.message(
      'from',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `Done!`
  String get done {
    return Intl.message(
      'Done!',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Nenhuma nota tem esse marcador`
  String get no_notes_this_tag {
    return Intl.message(
      'Nenhuma nota tem esse marcador',
      name: 'no_notes_this_tag',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Compose a new note`
  String get compose_new_note {
    return Intl.message(
      'Compose a new note',
      name: 'compose_new_note',
      desc: '',
      args: [],
    );
  }

  /// `Choose a note`
  String get choose_a_note {
    return Intl.message(
      'Choose a note',
      name: 'choose_a_note',
      desc: '',
      args: [],
    );
  }

  /// `Trash will be cleaned every 2 weeks`
  String get trash_will_clean {
    return Intl.message(
      'Trash will be cleaned every 2 weeks',
      name: 'trash_will_clean',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Note is empty`
  String get note_is_empty {
    return Intl.message(
      'Note is empty',
      name: 'note_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `others`
  String get others {
    return Intl.message(
      'others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Tagged notes on home screen?`
  String get should_tagged_notes_appear_home_title {
    return Intl.message(
      'Tagged notes on home screen?',
      name: 'should_tagged_notes_appear_home_title',
      desc: '',
      args: [],
    );
  }

  /// `Should tagged notes apear on home screen?`
  String get should_tagged_notes_appear_home_subtitle {
    return Intl.message(
      'Should tagged notes apear on home screen?',
      name: 'should_tagged_notes_appear_home_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose a option`
  String get choose_a_option {
    return Intl.message(
      'Choose a option',
      name: 'choose_a_option',
      desc: '',
      args: [],
    );
  }

  /// `Move note to trash?`
  String get move_note_to_trash {
    return Intl.message(
      'Move note to trash?',
      name: 'move_note_to_trash',
      desc: '',
      args: [],
    );
  }

  /// `Archive selected notes?`
  String get archive_selected_notes {
    return Intl.message(
      'Archive selected notes?',
      name: 'archive_selected_notes',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}