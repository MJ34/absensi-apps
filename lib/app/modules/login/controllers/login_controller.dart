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
            if (passC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Belum Verifikasi",
              middleText: "Silahkan Verifikasi Email Anda",
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar('Berhasil', 'Email Verifikasi Telah Dikirim');
                    } catch (e) {
                      Get.snackbar('Error',
                          'Tidak dapat mengirim email verifikasi, Hubungi admin');
                    }
                  },
                  child: Text("Kirim Ulang"),
                ),
              ],
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
