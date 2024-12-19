import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/video_controller.dart';

class HomeView extends GetView<VideoController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('视频转实况'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => controller.selectedVideo.value != null
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text('视频已选择'),
                      ),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text('点击选择视频'),
                      ),
                    )),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                child: const Text('选择视频'),
                onPressed: () => controller.pickVideo(),
              ),
              const SizedBox(height: 16),
              Obx(() => controller.selectedVideo.value != null
                  ? CupertinoButton.filled(
                      child: const Text('开始转换'),
                      onPressed: () => controller.convertVideo(),
                    )
                  : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
