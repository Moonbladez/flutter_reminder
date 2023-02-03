import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminders/models/reminder/reminder.dart';
import 'package:reminders/models/todo_list/todo_list.dart';

class DatabaseService {
  final String uid;
  final FirebaseFirestore _database;
  final DocumentReference _userRef;

  DatabaseService({required this.uid})
      : _database = FirebaseFirestore.instance,
        _userRef = FirebaseFirestore.instance.collection("users").doc(uid);

  Stream<List<ToDoList>> toDoListStream() {
    return _userRef.collection("todo_lists").snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (toDoListSnapshot) => ToDoList.fromJson(
                  toDoListSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Reminder>> reminderStream() {
    return _userRef.collection("reminders").snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (reminderSnapshot) => Reminder.fromJSON(
                  reminderSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  addToDoList({required ToDoList toDoList}) async {
    final toDoListRef = _userRef.collection("todo_lists").doc(toDoList.id);
    toDoList.id = toDoListRef.id;
    try {
      toDoListRef.set(
        toDoList.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteToDoList(ToDoList toDoList) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    final toDoRef = _userRef.collection("todo_lists").doc(toDoList.id);

    final reminderShapshots = await _userRef
        .collection("reminders")
        .where("list.id", isEqualTo: toDoList.id)
        .get();
    //delete reminders
    for (var doc in reminderShapshots.docs) {
      batch.delete(doc.reference);
    }
    // delete todo
    batch.delete(toDoRef);
    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  Future addReminder({required Reminder reminder}) async {
    var remindersRef = _userRef.collection("reminders").doc();
    final listRef = _userRef.collection("todo_lists").doc(reminder.list["id"]);

    reminder.id = remindersRef.id;

    WriteBatch batch = _database.batch();
    batch.set(remindersRef, reminder.toJSON());
    batch.update(
      listRef,
      {"reminder_count": reminder.list["reminder_count"] + 1},
    );
    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  deleteReminder(Reminder reminder, ToDoList toDoListForReminder) {
    final reminderRef = _userRef.collection("reminders").doc(reminder.id);
    reminder.id = reminderRef.id;
    WriteBatch batch = _database.batch();

    final listRef = _userRef.collection("todo_lists").doc(
          reminder.list["id"],
        );

    batch.delete(reminderRef);
    batch.update(
      listRef,
      {"reminder_count": toDoListForReminder.reminderCount - 1},
    );

    try {
      batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
