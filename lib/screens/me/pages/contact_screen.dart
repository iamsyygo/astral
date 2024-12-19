import 'package:flutter/cupertino.dart';
import '../../../widgets/sheet_view.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: '返回',
        middle: Text('联系我们'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SheetView(
              children: [
                SheetViewItem(
                  icon: CupertinoIcons.mail,
                  iconColor: const Color.fromARGB(255, 60, 154, 255),
                  title: '邮箱',
                  trailing: const Text('contact@astral.com'),
                  onTap: () {},
                ),
                SheetViewItem(
                  icon: CupertinoIcons.chat_bubble_2,
                  iconColor: CupertinoColors.systemGreen,
                  title: '微信公众号',
                  trailing: const Text('Astral星云'),
                  onTap: () {},
                ),
                SheetViewItem(
                  icon: CupertinoIcons.phone,
                  iconColor: CupertinoColors.systemBlue,
                  title: '客服电话',
                  trailing: const Text('400-888-8888'),
                  onTap: () {},
                ),
                SheetViewItem(
                  icon: CupertinoIcons.question_circle,
                  iconColor: CupertinoColors.systemOrange,
                  title: '常见问题',
                  trailing: const CupertinoListTileChevron(),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
