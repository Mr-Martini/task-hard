import 'package:hive/hive.dart';

import '../../generated/l10n.dart';

class HiveController {
  Box<dynamic> db = Hive.box('notes');
  Box<dynamic> tagBox = Hive.box('tags');

  void writeHive(String key, String title, String note, String activeColor) {
    Map<String, dynamic> value = {
      'title': title,
      'key': key,
      'note': note,
      'color': activeColor,
      'lastEdited': DateTime.now(),
    };

    db.put(key, addValue(key, value));
  }

  void deleteNote(String key) {
    db.delete(key);
  }

  void createCopy(
      String key, String title, String note, String activeColor, S translate) {
    title = title ?? '';

    Map<String, dynamic> value = {
      'title': '$title - ${translate.copy}',
      'key': key,
      'note': note,
      'color': activeColor,
      'lastEdited': DateTime.now(),
    };

    db.put(key, value);
  }

  dynamic getAll() {
    return db.values;
  }

  Map<dynamic, dynamic> getNote(String key) {
    return db.get(key, defaultValue: {});
  }

  void expireNote(String key) {
    Map<String, dynamic> value = {"expired": true};
    db.put(key, addValue(key, value));
  }

  void createReminder(
      String key, DateTime reminderDate, String repeat, int reminderKey) {
    Map<String, dynamic> value = {
      'reminderDate': reminderDate,
      'lastEdited': DateTime.now(),
      'repeat': repeat,
      'key': key,
      'reminderKey': reminderKey ?? key.hashCode,
      'expired': false
    };
    db.put(key, addValue(key, value));
  }

  void putTagOnNote(String key, String tagName) {

    var note = getNote(key);

    List<dynamic> tags = note['tags'] ?? [];

    if (!tags.contains(tagName)) {
      tags.add(tagName);
    }

    Map<String, dynamic> value = {
      'tags': tags,
      'key': key,
    };
    db.put(key, addValue(key, value));
  }

  void putTagsBulk(String key, List<dynamic> tags) {
    Map<String, dynamic> value = {
      'tags': tags,
      'key': key,
    };
    db.put(key, addValue(key, value));
  }

  void deleteTagFromNote(String key, String tagName) {

    var note = getNote(key);

    List<dynamic> tags = note['tags'] ?? [];

    tags.remove(tagName);

    Map<String, dynamic> value = {
      'tags': tags,
      'key': key,
    };
    db.put(key, addValue(key, value));
  }

  void deleteAllTagsFromNote(String key) {
    Map<String, dynamic> value = {
      'tags': [],
      'key': key,
    };
    db.put(key, addValue(key, value));
  }

  void updateColor(String key, String color) {
    Map<String, dynamic> value = {
      'color': color,
      'key': key,
    };
    db.put(key, addValue(key, value));
  }

  void deleteReminder(String key) {
    Map<String, dynamic> value = {
      'reminderDate': null,
    };

    db.put(key, addValue(key, value));
  }

  void moveToArchive(String key) {
    Map<String, dynamic> value = {
      'archived': true,
    };

    db.put(key, addValue(key, value));
  }

  void moveToTrash(String key) {
    Map<String, dynamic> value = {
      'trash': true,
    };

    db.put(key, addValue(key, value));
  }

  void restoreFromArchive(String key) {
    Map<String, dynamic> value = {
      'archived': false,
    };

    db.put(key, addValue(key, value));
  }

  void restoreFromTrash(String key) {
    Map<String, dynamic> value = {
      'trash': false,
    };

    db.put(key, addValue(key, value));
  }

  Map<dynamic, dynamic> addValue(String key, Map<dynamic, dynamic> value) {
    Map<dynamic, dynamic> note = db.get(key, defaultValue: {});

    Map<dynamic, dynamic> aux = Map<dynamic, dynamic>.from(note);

    aux.addAll(value);

    return aux;
  }

  //tag box functions

  Map<dynamic, dynamic> getTag(String tagKey) {
    return tagBox.get(tagKey, defaultValue: {});
  }

  void deleteTag(String tagKey) {
    tagBox.delete(tagKey);
  }

  bool putTag(String tagName, String key) {
    bool hasTag = false;

    for (var tag in getTags()) {
      if (tag['name'] == tagName) {
        hasTag = true;
        break;
      }
    }

    if (hasTag) return false;

    Map<String, dynamic> value = {'name': tagName, 'key': key};
    tagBox.put(key, addValueTag(key, value));

    return true;
  }

  void updateTagColor(String color, String tagKey) {
    Map<String, dynamic> value = {
      'color': color,
    };
    tagBox.put(tagKey, addValueTag(tagKey, value));
  }

  bool updateTagName(String tagKey, String newTagName) {
    bool hasTag = false;

    for (var tag in getTags()) {
      if (tag['name'] == newTagName) {
        hasTag = true;
        break;
      }
    }

    if (hasTag) {
      return false;
    }

    String oldTagName = getTag(tagKey)['name'];

    Map<String, dynamic> value = {
      'name': newTagName,
    };
    tagBox.put(tagKey, addValueTag(tagKey, value));

    for (var note in getAll()) {
      if (note['tagName'] == oldTagName) {
        putTagOnNote(note['key'], newTagName);
      }
    }

    return true;
  }

  List getTags() {
    return tagBox.values.toList();
  }

  Map<dynamic, dynamic> addValueTag(
      String tagKey, Map<dynamic, dynamic> value) {
    Map<dynamic, dynamic> note = tagBox.get(tagKey, defaultValue: {});

    Map<dynamic, dynamic> aux = Map<dynamic, dynamic>.from(note);

    aux.addAll(value);

    return aux;
  }
}
