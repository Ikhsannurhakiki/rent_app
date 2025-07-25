import 'package:flutter/material.dart';
import 'package:rent_app/presentation/style/colors/app_colors.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  final List<ChatItem> dummyChats = const [
    ChatItem(
      name: "Alice",
      lastMessage: "See you tomorrow!",
      time: "09:24",
      avatarUrl: "https://i.pravatar.cc/150?img=1",
    ),
    ChatItem(
      name: "Bob",
      lastMessage: "Let's meet at 3PM.",
      time: "08:17",
      avatarUrl: "https://i.pravatar.cc/150?img=2",
    ),
    ChatItem(
      name: "Charlie",
      lastMessage: "Thanks for the ride!",
      time: "Yesterday",
      avatarUrl: "https://i.pravatar.cc/150?img=3",
    ),
    ChatItem(
      name: "Diana",
      lastMessage: "I'm on my way.",
      time: "Sun",
      avatarUrl: "https://i.pravatar.cc/150?img=4",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Chats', style: TextStyle(color: Colors.white))),
      body: ListView.builder(
        itemCount: dummyChats.length,
        itemBuilder: (context, index) {
          final chat = dummyChats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat.avatarUrl),
            ),
            title: Text(chat.name),
            subtitle: Text(
              chat.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              chat.time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              // Navigate to chat screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(name: chat.name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl;

  const ChatItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
  });
}

class ChatScreen extends StatelessWidget {
  final String name;

  const ChatScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: const Center(child: Text("Chat screen content here")),
    );
  }
}
