import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImage() async {
        image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          print(image!.name);
          print(image!.name.split(".").last);
          print(image!.path);
        }  else {
          print(image);
        }
        update();
  }

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
