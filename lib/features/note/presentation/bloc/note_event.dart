part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class GetNoteByKey extends NoteEvent {
  final String key;

  GetNoteByKey({@required this.key});

  @override
  List<Object> get props => [key];
}

class WriteNoteContent extends NoteEvent {
  final String content;
  final String key;

  WriteNoteContent({@required this.content, @required this.key});

  @override
  List<Object> get props => [content, key];
}

class WriteNoteTitle extends NoteEvent {
  final String title;
  final String key;

  WriteNoteTitle({@required this.title, @required this.key});

  @override
  List<Object> get props => [title, key];
}

class WriteNoteColor extends NoteEvent {
  final Color color;
  final String key;

  WriteNoteColor({@required this.color, @required this.key});

  @override
  List<Object> get props => [color, key];
}

class WriteNoteReminder extends NoteEvent {
  final DateTime reminder;
  final TimeOfDay time;
  final String repeat;
  final String key;
  final String title;
  final String message;

  WriteNoteReminder({
    @required this.reminder,
    @required this.time,
    @required this.repeat,
    @required this.key,
    @required this.title,
    @required this.message,
  });

  @override
  List<Object> get props => [reminder, time, repeat, key];
}

class DeleteNoteReminder extends NoteEvent {
  final String key;

  DeleteNoteReminder({@required this.key});

  @override
  List<Object> get props => [key];
}

class DeleteNote extends NoteEvent {
  final String key;

  DeleteNote({@required this.key});

  @override
  List<Object> get props => [key];
}

class ArchiveNote extends NoteEvent {
  final String key;

  ArchiveNote({@required this.key});

  @override
  List<Object> get props => [key];
}

class CopyNote extends NoteEvent {
  final String key;
  final String title;
  final String content;
  final Color color;

  CopyNote({
    @required this.key,
    @required this.title,
    @required this.content,
    @required this.color,
  });

  @override
  List<Object> get props => [key, title, content, color];
}
