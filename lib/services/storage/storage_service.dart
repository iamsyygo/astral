import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class User {
  final int id;
  final String username;
  final String account;
  final String? email;
  final String? avatar;
  final String? googleId;
  final String? githubId;
  final int status;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.username,
    required this.account,
    this.email,
    this.avatar,
    this.googleId,
    this.githubId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      account: json['account'],
      email: json['email'],
      avatar: json['avatar'],
      googleId: json['googleId'],
      githubId: json['githubId'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'account': account,
        'email': email,
        'avatar': avatar,
        'googleId': googleId,
        'githubId': githubId,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

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
