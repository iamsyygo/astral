import 'package:astral/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("关于"),
      ),
      body: ListView(
        children: const [
          // 路由&导航
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onPressed() {
    Get.toNamed(AppRoutes.home);
  }
}
