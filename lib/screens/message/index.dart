import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../common/app_colors.dart';
import 'widgets/message_search_bar.dart';
import 'widgets/story_list.dart';
import 'widgets/chat_list.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      child: CustomScrollView(
        slivers: [
          // 顶部搜索栏
          const CupertinoSliverNavigationBar(
            largeTitle: Text('消息'),
            border: null,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MessageSearchBar(),
                ),
                // 好友故事列表
                const StoryList(),
                Container(
                  height: 8,
                  color: CupertinoColors.systemGrey6,
                ),
                // 聊天列表
                const ChatList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
