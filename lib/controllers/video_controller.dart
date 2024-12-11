import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoController extends GetxController {
  final selectedVideo = Rx<XFile?>(null);
  final isConverting = false.obs;

  Future<void> pickVideo() async {
    try {
      // 检查权限
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        Get.snackbar(
          '权限错误',
          '请授予应用访问存储的权限以选择视频',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final ImagePicker picker = ImagePicker();
      final XFile? video = await picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 10), // 限制视频时长
      );

      if (video != null) {
        selectedVideo.value = video;
        Get.snackbar(
          '成功',
          '已选择视频',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        '错误',
        '选择视频失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> convertVideo() async {
    if (selectedVideo.value == null) return;

    try {
      isConverting.value = true;
      // TODO: 实现视频转换逻辑
      await Future.delayed(const Duration(seconds: 2)); // 模拟转换过程
      Get.snackbar(
        '成功',
        '视频已转换为实况',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        '错误',
        '转换失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isConverting.value = false;
    }
  }
}
