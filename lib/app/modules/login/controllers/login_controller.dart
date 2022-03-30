import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preferensi/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      //eksekusi
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.defaultDialog(
              title: "Verifikasi Email",
              content: Text("Silahkan verifikasi email anda"),
              confirm: TextButton(
                child: Text("Verifikasi"),
                onPressed: () {
                  userCredential.user!.sendEmailVerification();
                  Get.back();
                },
              )
            );
          }
        }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar('Error', 'Email tidak terdaftar');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Error', 'Password salah');
        }
      } catch (e) {
        Get.snackbar('Error', 'Terjadi kesalahan');
      }
    } else {
      Get.snackbar('Error', 'Email dan Password tidak boleh kosong',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
