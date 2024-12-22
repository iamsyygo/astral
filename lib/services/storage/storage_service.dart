import 'package:astral/models/user_models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  // 存储服务，用于存储和读取本地数据
  late final GetStorage _box;

  // 添加响应式用户数据
  final Rxn<User> user = Rxn<User>();

  // 初始化
  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();

    // 初始化时检查并加载缓存的用户数据
    final userData = getUserData();
    if (userData != null) {
      user.value = User.fromJson(userData);
    }

    return this;
  }

  // 写入 accessToken 到本地
  Future<void> saveToken(String token) async {
    await _box.write('accessToken', token);
  }

  // 写入 refreshToken 到本地
  Future<void> saveRefreshToken(String token) async {
    await _box.write('refreshToken', token);
  }

  // 读取 token
  String? getToken() {
    return _box.read('accessToken');
  }

  // 读取 refreshToken
  String? getRefreshToken() {
    return _box.read('refreshToken');
  }

  // 清除 token
  Future<void> clearToken() async {
    await _box.remove('accessToken');
  }

  // 清除 refreshToken
  Future<void> clearRefreshToken() async {
    await _box.remove('refreshToken');
  }

  // 写入 userData 到本地
  Future<void> setUserData(Map<String, dynamic> userData) async {
    await _box.write('userData', userData);
    user.value = User.fromJson(userData);
  }

  Map<String, dynamic>? getUserData() {
    return _box.read('userData');
  }

  Future<void> clearUserData() async {
    await _box.remove('userData');
    user.value = null;
  }
}
