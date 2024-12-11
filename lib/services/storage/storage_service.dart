import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  // 存储服务，用于存储和读取本地数据
  late final GetStorage _box;

  // 初始化
  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // 写入 token 到本地
  Future<void> saveToken(String token) async {
    await _box.write('token', token);
  }

  // 读取 token
  String? getToken() {
    return _box.read('token');
  }

  // 清除 token
  Future<void> clearToken() async {
    await _box.remove('token');
  }
}
