import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Error", "Password terlalu singkat min 6 karakter!!");
          }
        } catch (e) {
         Get.snackbar("Error",
            "Tidak dapat membuat password baru. Hubungi admin / customer service.");
        }
      } else {
        Get.snackbar("Error",
            "Password baru harus diubah, jangan isi 'password' kembali ");
      }
    } else {
      Get.snackbar("Error", "Password baru wajib diisi!!");
    }
  }
}
