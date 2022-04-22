import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currC = TextEditingController();
  TextEditingController newC = TextEditingController();
  TextEditingController konfC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePass() async {
    if (currC.text.isNotEmpty &&
        newC.text.isNotEmpty &&
        konfC.text.isNotEmpty) {
      if (newC.text == konfC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currC.text);

          await auth.currentUser!.updatePassword(newC.text);

          Get.back();
          Get.snackbar("Berhasil", "Password berhasil diupdate");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar(
                "Error", "Input password salah. Tidak dapat update password!!");
          } else {
            Get.snackbar("Error", e.code.toLowerCase());
          }
        } catch (e) {
          Get.snackbar("Error", "Tidak dapat update password!!");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Error", "Konfirmasi password tidak cocok");
      }
    } else {
      Get.snackbar("Error", "Semua harus diisi!!");
    }
  }
}
