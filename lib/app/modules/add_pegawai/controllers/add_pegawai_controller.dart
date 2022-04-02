import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPegawai = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddPegawai.value = true;
      //eksekusi
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
        await auth.signInWithEmailAndPassword(
            email: emailAdmin, password: passAdminC.text);

        UserCredential pegawaiCredential =
        await auth.createUserWithEmailAndPassword(
            email: emailC.text, password: "password");

        if (pegawaiCredential.user != null) {
          String uid = pegawaiCredential.user!.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String(),
          });

          await pegawaiCredential.user!.sendEmailVerification();
          await auth.signOut();

          UserCredential userCredentialAdmin =
          await auth.signInWithEmailAndPassword(
              email: emailAdmin, password: passAdminC.text);

          Get.back(); //tutup dialog
          Get.back(); //back home
          Get.snackbar("Berhasil", "Berhasil menambal pegawai");
          isLoadingAddPegawai.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingAddPegawai.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi Kesalahan", "Password terlalu singkat!!");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan",
              "Pegawai sudah ada. Tidak dapat menambah pegawai!!");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Kesalahan", "Password Salah!!");
        } else {
          Get.snackbar("Error", e.code);
        }
      } catch (e) {
        isLoadingAddPegawai.value = false;
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambah pegawai!!");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Error", "Password wajib diisi untuk validasi");
    }
  }

  Future<void> addPegawai() async {
    if (nameC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        title: "Validasi Admin",
        content: Column(
          children: [
            Text("Masukan password validasi!!"),
            SizedBox(height: 10,),
            TextField(
              controller: passAdminC,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              isLoading.value = false;
              Get.back();
            },
            child: Text("Cancel"),
          ),
          Obx(() {
            return ElevatedButton(
              onPressed: () async {
                if (isLoadingAddPegawai.isFalse) {
                  await prosesAddPegawai();
                }
                isLoading.value = false;
              },
              child: Text(
                  isLoadingAddPegawai.isFalse ? "Add Pegawai" : "Loading.."),
            );
          }),
        ],
      );
    } else {
      Get.snackbar("Terjadi Kesalahan", "NIP, nama dan email harus diisi!!");
    }
  }
}
