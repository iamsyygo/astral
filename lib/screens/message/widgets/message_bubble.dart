import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ChatMessage {
  final String content;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.isMe,
    required this.timestamp,
  });
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final String avatar;

  const MessageBubble({
    super.key,
    required this.message,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe) _buildAvatar(),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: message.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: message.isMe
                      ? CupertinoColors.activeBlue
                      : CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  message.content,
                  style: TextStyle(
                    color: message.isMe
                        ? CupertinoColors.white
                        : CupertinoColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatTime(message.timestamp),
                style: const TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          if (message.isMe) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(avatar),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
}
