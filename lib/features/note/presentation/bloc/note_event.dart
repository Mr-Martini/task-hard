part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class GetNoteByKey extends NoteEvent {
  final String key;
  final WriteOn box;

  GetNoteByKey({@required this.key, @required this.box});

  @override
  List<Object> get props => [key, box];
}

class WriteNoteContent extends NoteEvent {
  final String content;
  final String key;
  final WriteOn box;

  WriteNoteContent({
    @required this.content,
    @required this.key,
    @required this.box,
  });

  @override
  List<Object> get props => [content, key, box];
}

class WriteNoteTitle extends NoteEvent {
  final String title;
  final String key;
  final WriteOn box;

  WriteNoteTitle({
    @required this.title,
    @required this.key,
    @required this.box,
  });

  @override
  List<Object> get props => [title, key, box];
}

class WriteNoteColor extends NoteEvent {
  final Color color;
  final String key;
  final WriteOn box;

  WriteNoteColor({@required this.color, @required this.key, @required this.box,});

  @override
  List<Object> get props => [color, key, box];
}

class WriteNoteReminder extends NoteEvent {
  final DateTime reminder;
  final TimeOfDay time;
  final String repeat;
  final String key;
  final String title;
  final String message;
  final WriteOn box;

  WriteNoteReminder({
    @required this.reminder,
    @required this.time,
    @required this.repeat,
    @required this.key,
    @required this.title,
    @required this.message,
    @required this.box,
  });

  @override
  List<Object> get props => [reminder, time, repeat, key, box];
}

class DeleteNoteReminder extends NoteEvent {
  final String key;
  final WriteOn box;

  DeleteNoteReminder({@required this.key, @required this.box});

  @override
  List<Object> get props => [key, box];
}

class DeleteNote extends NoteEvent {
  final String key;
  final WriteOn box;

  DeleteNote({@required this.key, @required this.box});

  @override
  List<Object> get props => [key, box];
}

class ArchiveNote extends NoteEvent {
  final String key;
  final WriteOn box;

  ArchiveNote({@required this.key, @required this.box});

  @override
  List<Object> get props => [key, box];
}

class CopyNote extends NoteEvent {
  final String key;
  final String title;
  final String content;
  final Color color;
  final WriteOn box;

  CopyNote({
    @required this.key,
    @required this.title,
    @required this.content,
    @required this.color,
    @required this.box,
  });

  @override
  List<Object> get props => [key, title, content, color, box];
}
