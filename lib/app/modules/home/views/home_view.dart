import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:preferensi/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
                  onPressed: () => Get.toNamed(Routes.PROFILE),
                  icon: Icon(Icons.person)),
         /* StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamRole(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }
              String role = snap.data!.data()!["role"];
              if (role == "admin") {
                //role admin
               return IconButton(
                  onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
                  icon: Icon(Icons.person));
              } else {
                return SizedBox();
              }
            }
          ),*/
        ],
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: () async {
            if (controller.isLoading.isFalse) {
              controller.isLoading.value = true;
              await FirebaseAuth.instance.signOut();
              controller.isLoading.value = false;
              Get.offAllNamed(Routes.LOGIN);
            }
          },
          child: controller.isLoading.isFalse
              ? Icon(Icons.logout)
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
