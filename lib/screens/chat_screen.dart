import 'package:flutter/material.dart';
import '../theme.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final String? avatarPath;
  final String? time;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.avatarPath,
    this.time,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Hi, how can I help you?',
      isUser: false,
    ),
    ChatMessage(
      text: 'Hello, I ordered two fried chicken burgers, can I know how much time it will get to arrive?',
      isUser: true,
      avatarPath: 'assets/images/image8.png',
    ),
    ChatMessage(
      text: 'Ok, please let me check!',
      isUser: false,
    ),
    ChatMessage(
      text: 'Sure...',
      isUser: true,
      avatarPath: 'assets/images/image8.png',
    ),
    ChatMessage(
      text: "It'll get 25 minutes to arrive to your address",
      isUser: false,
      time: '24 minutes ago',
    ),
    ChatMessage(
      text: 'Ok, thanks for your support.',
      isUser: true,
      avatarPath: 'assets/images/image8.png',
    ),
  ];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        avatarPath: 'assets/images/image8.png',
      ));
      _controller.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: _messages.length,
                itemBuilder: (_, i) {
                  final msg = _messages[i];
                  // Show time divider if present
                  return Column(
                    children: [
                      if (msg.time != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(msg.time!,
                              style: AppTextStyle.roboto(
                                  size: 11, color: AppColors.textGrey)),
                        ),
                      _buildBubble(msg),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  size: 18, color: AppColors.dark),
            ),
          ),
          const Spacer(),
          const Icon(Icons.more_horiz, size: 24, color: AppColors.dark),
        ],
      ),
    );
  }

  Widget _buildBubble(ChatMessage msg) {
    if (msg.isUser) {
      // User bubble: red, right aligned, with avatar
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: Text(msg.text,
                  style: AppTextStyle.roboto(
                      size: 14, color: Colors.white, height: 1.5)),
            ),
          ),
          const SizedBox(width: 10),
          ClipOval(
            child: Image.asset(
              msg.avatarPath ?? 'assets/images/image8.png',
              width: 38, height: 38,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 38, height: 38,
                decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 20, color: AppColors.grey),
              ),
            ),
          ),
        ],
      );
    } else {
      // Support bubble: grey, left aligned, with bot icon
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: const Icon(Icons.support_agent,
                size: 20, color: AppColors.dark),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(4),
                ),
              ),
              child: Text(msg.text,
                  style: AppTextStyle.roboto(
                      size: 14, color: AppColors.dark, height: 1.5)),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, -3)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(26),
              ),
              child: TextField(
                controller: _controller,
                style: AppTextStyle.roboto(size: 14, color: AppColors.dark),
                decoration: InputDecoration(
                  hintText: 'Type here...',
                  hintStyle: AppTextStyle.roboto(
                      size: 14, color: AppColors.textGrey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
