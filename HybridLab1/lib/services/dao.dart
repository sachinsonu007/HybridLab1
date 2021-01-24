import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_note/models/note_model.dart';
import 'package:firestore_note/shared/helpers.dart';
import 'package:firestore_note/views/auth/auth_controller.dart';
import 'package:get/get.dart';

//Data base access object
class DAO {
  FirebaseFirestore _firestore = FirebaseFirestore.instance; //
  final uid = AuthController.to.uid;
  Future<void> addNote(title, content) async {
    await _firestore.collection("users").doc(uid).collection("notes").add(
        {'createdAt': Timestamp.now(), 'title': title, "details": content});
    Get.back(); // Go back
    helpers.showToast("Note added successfully."); //Show toast
  }

  Stream<List<NoteModel>> getNotes() {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<NoteModel> result = List<NoteModel>();
      query.docs.forEach((element) {
        result.add(NoteModel.fromDocumentSnapshot(element));
      });
      return result;
    });
  }

  updateNote(NoteModel noteModel) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(noteModel.id)
        .update({
      'createdAt': Timestamp.now(),
      'title': noteModel.title,
      "details": noteModel.details
    });
    Get.back();
    helpers.showToast("Note Updated Successfully");
  }

  deleteNote(String id) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .doc(id)
        .delete();

    Get.back();
    helpers.showToast("Note deleted successfully.");
  }
}
