import 'package:flutter/material.dart';
import 'package:phishsense_sms/profile.dart';
import 'spam_folder.dart';
import 'profile.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  String? get message => null;

  @override
  Widget build(BuildContext context) {
    final messages = [
      {
        "sender": "+63 958-477-3278",
        "message":
        "Congratulations! You have won a brand new iPhone 15 Pro Max! 🎉 Just click here to claim your FREE prize now: https://win-free-iphone-now...",
        "time": "now",
        "isPhishing": true,
      },
      {
        "sender": "Mama Globe",
        "message":
        "Good morning, anak. Kumain ka na? Huwag ka magpapalipas. May allowance ka pa?",
        "time": "2m ago",
        "isPhishing": false,
      },
      {
        "sender": "Maya",
        "message":
        "Awesome! We have increased your wallet limit to ₱500,000 so you can do more with your Maya account! ...",
        "time": "15m ago",
        "isPhishing": false,
      },
      {
        "sender": "Bank Support",
        "message":
        "[URGENT] Your bank account has been temporarily suspended due to suspicious activity. Click here to verify your information and ...",
        "time": "1h ago",
        "isPhishing": true,
      },
      {
        "sender": "Ninang Marj",
        "message":
        "Merry Christmas, Inaanak! Puntahan mo ako dito sa bahay, kuhanin mo ang papasko ko sayo.",
        "time": "2h ago",
        "isPhishing": false,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EC),
      body: SafeArea(
        child: Column(
          children: [

            /// PHISHSENSE HEADER
            const _TopHeader(),

            /// MESSAGING HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Messaging",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "5 unread",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.folder_shared_outlined, size: 35),
                    color: const Color(0xFF1A7A72),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SpamFolderPage(),
                        ),
                      );
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.tune, size: 30),
                    color: const Color(0xFF1A7A72),
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            /// SEARCH BAR
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: _SearchBar(),
            ),

            const SizedBox(height: 14),

            /// MESSAGE LIST
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: messages.length,

                /// subtle separator between conversations
                separatorBuilder: (_, __) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 1,
                  color: Colors.black.withOpacity(.06),
                ),

                itemBuilder: (context, index) {
                  final item = messages[index];
                  return _MessageCard(
                    sender: item["sender"] as String,
                    message: item["message"] as String,
                    time: item["time"] as String,
                    isPhishing: item["isPhishing"] as bool,
                  );
                },
              ),
            ),

            /// bottom bar
            Container(
              height: 20,
              width: double.infinity,
              color: const Color(0xFF1A7A72),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A7A72),
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 16),
      child: Row(
        children: const [
          Icon(
            Icons.phishing,
            color: Color(0xFF888880),
            size: 28,
          ),
          SizedBox(width: 6),
          Text(
            "Phish",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black26,
                  offset: Offset(0,2),
                )
              ],
            ),
          ),
          Text(
            "Sense",
            style: TextStyle(
              color: Color(0xFFE0A800),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black26,
                  offset: Offset(0,2),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF3EEE4),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            size: 28,
            color: Color(0xFF7A7A7A),
          ),
          SizedBox(width: 10),
          Text(
            "Search",
            style: TextStyle(
              color: Color(0xFF9C9C9C),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  final String sender;
  final String message;
  final String time;
  final bool isPhishing;

  const _MessageCard({
    required this.sender,
    required this.message,
    required this.time,
    required this.isPhishing,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor =
    isPhishing ? const Color(0xFFF2554F) : const Color(0xFF06C85E);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    sender,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF5A5A5A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isPhishing ? "Phishing Detected" : "Safe Message",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3EEE4),
                borderRadius: BorderRadius.circular(22),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 10,
                        color: badgeColor,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 12, 16, 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  message,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.4,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 6),

                              Text(
                                time,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}