import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.currC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Current Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.newC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "New Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.konfC,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Konfirmasi Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.updatePass();
                }
              },
              child: Text((controller.isLoading.isFalse)
                  ? "Ganti Password"
                  : "Loading..."),
            ),
          ),
        ],
      ),
    );
  }
}
