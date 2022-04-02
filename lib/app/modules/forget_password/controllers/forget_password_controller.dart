import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future <void> sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.snackbar("Sukses", "Kami telah mengirimkan email reset Password, Periksa email sekarang..");
      } catch (e) {
        Get.snackbar("Gagal", "Tidak dapat mengirimkan email reset Password");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
