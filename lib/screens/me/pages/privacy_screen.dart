import 'package:flutter/cupertino.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: '返回',
        middle: Text('隐私政策'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '最后更新日期：2024年3月1日',
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '感谢您使用我们的应用。我们非常重视您的隐私权，并致力于保护您的个人信息。本隐私政策旨在向您说明我们如何收集、使用和保护您的个人信息。\n\n'
                '1. 信息收集\n'
                '我们可能收集以下类型的信息：\n'
                '• 基本信息：包括您的姓名、电子邮件地址\n'
                '• 设备信息：设备型号、操作系统版本\n'
                '• 使用数据：应用使用情况和偏好设置\n\n'
                '2. 信息使用\n'
                '我们收集的信息将用于：\n'
                '• 提供和改进我们的服务\n'
                '• 个性化您的使用体验\n'
                '• 发送服务通知\n\n'
                '3. 信息保护\n'
                '我们采用业界标准的安全措施保护您的个人信息，防止未经授权的访问、使用或泄露。\n\n'
                '4. 信息共享\n'
                '除非获得您的明确同意，我们不会与第三方共享您的个人信息。\n\n'
                '5. 您的权利\n'
                '您有权访问、更正或删除您的个人信息。如需行使这些权利，请联系我们。\n\n'
                '6. 政策更新\n'
                '我们可能会不时更新本隐私政策，更新后的政策将在应用内发布。\n\n'
                '7. 联系我们\n'
                '如果您对本隐私政策有任何疑问，请通过以下方式联系我们：\n'
                'support@example.com',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
