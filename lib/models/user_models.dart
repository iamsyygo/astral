class User {
  final int id;
  final String username;
  final String account;
  final String? email;
  final String? avatar;
  final String? googleId;
  final String? githubId;
  final String? description;
  final int status;
  final int sex;
  final String createdAt;
  final String? updatedAt;

  User({
    required this.id,
    required this.username,
    required this.account,
    this.email,
    this.avatar,
    this.googleId,
    this.githubId,
    this.description,
    this.updatedAt,
    required this.status,
    this.sex = 2,
    required this.createdAt,
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
      description: json['description'],
      status: json['status'],
      sex: json['sex'],
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
        'description': description,
        'status': status,
        'sex': sex,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
