import 'package:flutter/cupertino.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: '返回',
        middle: Text('用户协议'),
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
                '欢迎使用 Astral 视频转实况服务。本协议是您与 Astral（以下简称"我们"）之间关于您使用 Astral 服务所订立的协议。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '1. 服务内容\n\n我们为用户提供视频转实况的相关服务。您需要：\n• 完成实名认证\n• 确保上传内容的合法性\n• 遵守相关法律法规',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '2. 账号注册\n\n您承诺：\n• 提供真实、准确的注册信息\n• 妥善保管账号密码\n• 不得将账号转让或出借给他人使用',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '3. 用户行为规范\n\n您应当遵守：\n• 遵守法律法规\n• 尊重知识产权\n• 维护网络秩序\n• 保护个人隐私',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '4. 服务变更、中断或终止\n\n我们保留随时修改或中断服务的权利，若有重大变更会提前通知用户。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '5. 隐私保护\n\n我们重视用户的隐私保护，具体详见《隐私政策》。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '6. 知识产权\n\n本应用的所有权、运营权和知识产权均归我们所有。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '7. 免责声明\n\n在法律允许的范围内，我们对使用本服务可能产生的风险或损失不承担责任。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '8. 协议修改\n\n我们保留修改本协议的权利，修改后的协议将在应用内公布。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '9. 法律适用与管辖\n\n本协议适用中华人民共和国法律。',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
