import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid) async {
    if (nameC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await db.collection("pegawai").doc(uid).update({
          "name": nameC.text,
        });
        Get.snackbar("Success", "Berhasil Update Profile.");
      } catch (e) {
        Get.snackbar("Error", "Tidak dapat Update Profile.");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
