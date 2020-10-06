import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NoteReminder extends Equatable {
  final DateTime reminder;
  final String repeat;
  final bool expired;

  NoteReminder({
    @required this.reminder,
    @required this.expired,
    @required this.repeat,
  });

  @override
  List<Object> get props => [reminder, repeat, expired];
}
