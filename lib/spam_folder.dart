import 'package:flutter/material.dart';

class SpamFolderPage extends StatefulWidget {
  const SpamFolderPage({super.key});

  @override
  State<SpamFolderPage> createState() => _SpamFolderPageState();
}

class _SpamFolderPageState extends State<SpamFolderPage> {
  String selectedPeriod = "2 days";

  final List<Map<String, dynamic>> spamMessages = [
    {
      "sender": "+63 958-477-3278",
      "message":
      "Congratulations! You have won a brand new iPhone 15 Pro Max! 🎉 Just click here to claim your FREE prize now: https://win-free-iphone-now...",
      "time": "now",
      "reasons": [
        "⚠️ Suspicious Link",
        "⏰ Urgency Manipulation",
        "🎁 Unrealistic Reward"
      ],
    },
    {
      "sender": "Bank Support",
      "message":
      "[URGENT] Your bank account has been temporarily suspended due to suspicious activity. Click here to verify your information and ...",
      "time": "1h ago",
      "reasons": [
        "⚠️ Suspicious Link",
        "🔑 Credential Theft",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EC),
      body: SafeArea(
        child: Column(
          children: [
            _TopHeader(
              onClose: () => Navigator.pop(context),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Spam Folder",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Detected smishing messages",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 18),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EEE4),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Auto-delete period",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Automatically delete smishing messages after",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7A7A7A),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A7A72),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedPeriod,
                              dropdownColor: const Color(0xFF1A7A72),
                              iconEnabledColor: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "2 days",
                                  child: Text("2 days"),
                                ),
                                DropdownMenuItem(
                                  value: "7 days",
                                  child: Text("7 days"),
                                ),
                                DropdownMenuItem(
                                  value: "30 days",
                                  child: Text("30 days"),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedPeriod = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF2554F),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Delete all messages",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: spamMessages.length,
                separatorBuilder: (_, __) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 26),
                  height: 1,
                  color: Colors.black.withOpacity(.06),
                ),
                itemBuilder: (context, index) {
                  final item = spamMessages[index];
                  return _SpamMessageCard(
                    sender: item["sender"] as String,
                    message: item["message"] as String,
                    time: item["time"] as String,
                    reasons: item["reasons"] as List<String>,
                  );
                },
              ),
            ),

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
  final VoidCallback onClose;

  const _TopHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A7A72),
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 16),
      child: Row(
        children: [
          const Icon(
            Icons.phishing,
            color: Color(0xFF888880),
            size: 28,
          ),
          const SizedBox(width: 6),
          const Text(
            "Phish",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black26,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          const Text(
            "Sense",
            style: TextStyle(
              color: Color(0xFFE0A800),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black26,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _SpamMessageCard extends StatelessWidget {
  final String sender;
  final String message;
  final String time;
  final List<String> reasons;

  const _SpamMessageCard({
    required this.sender,
    required this.message,
    required this.time,
    required this.reasons,
  });

  @override
  Widget build(BuildContext context) {
    const badgeColor = Color(0xFFF2554F);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
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
                  const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Phishing Detected",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3EEE4),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 8,
                        color: badgeColor,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 14, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                      message,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.45,
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
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "Why this was flagged:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),

                              const SizedBox(height: 6),

                              ...reasons.map(
                                    (reason) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    reason,
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      color: Color(0xFF444444),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        const Color(0xFF06C85E),
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        "Restore",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: badgeColor,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        "Block",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
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