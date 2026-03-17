import 'package:flutter/material.dart';
import 'spam_folder.dart';
import 'profile.dart';
import 'label_detection.dart';

class MessagesPage extends StatefulWidget {
  final String name;
  final int defaultSmsIndex;
  final bool smsPermission;
  final bool notificationPermission;
  final bool contactsPermission;
  final bool spamFolderEnabled;

  final bool shareAnonymousData;
  final bool showDetectionPopup;
  final ValueChanged<bool> onChangeShareAnonymousData;
  final ValueChanged<bool> onChangeShowDetectionPopup;

  const MessagesPage({
    super.key,
    required this.name,
    required this.defaultSmsIndex,
    required this.smsPermission,
    required this.notificationPermission,
    required this.contactsPermission,
    required this.spamFolderEnabled,
    required this.shareAnonymousData,
    required this.showDetectionPopup,
    required this.onChangeShareAnonymousData,
    required this.onChangeShowDetectionPopup,
  });

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late int _defaultSmsIndex;
  late bool _smsPermission;
  late bool _notificationPermission;
  late bool _contactsPermission;
  late bool _spamFolderEnabled;
  late bool _shareAnonymousData;
  late bool _showDetectionPopup;

  @override
  void initState() {
    super.initState();
    _defaultSmsIndex = widget.defaultSmsIndex;
    _smsPermission = widget.smsPermission;
    _notificationPermission = widget.notificationPermission;
    _contactsPermission = widget.contactsPermission;
    _spamFolderEnabled = widget.spamFolderEnabled;
    _shareAnonymousData = widget.shareAnonymousData;
    _showDetectionPopup = widget.showDetectionPopup;
  }

  void _showCenterNote(String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(.15),
      builder: (_) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.12),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Color(0xFF1A7A72),
                  size: 22,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).maybePop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = [
      {
        "sender": "+63 958-477-3278",
        "message":
        "Congratulations! YOU WON \$1,000,000 in the Mega Millions Lottery! 🤑 To process your claim, please reply with your full name, home address, date of birth, and a valid ID number. Click here to verify instantly: https://mega-millions-winner.com Act fast! Reply NOW to avoid losing your prize!",
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
        "Awesome! We have increased your wallet limit to ₱500,000 so you can do more with your Maya account!",
        "time": "15m ago",
        "isPhishing": false,
      },
      {
        "sender": "Bank Support",
        "message":
        "[URGENT] Your bank account has been temporarily suspended due to suspicious activity. Click here to verify your information and win something!",
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
      {
        "sender": "Jaica",
        "message": "Tel nasan ka?",
        "time": "5 days",
        "isPhishing": false,
      },
    ];

    return Scaffold(
      key: scaffoldKey,
      endDrawer: ProfileSidebar(
        name: widget.name,
        defaultSmsIndex: _defaultSmsIndex,
        smsPermission: _smsPermission,
        notificationPermission: _notificationPermission,
        contactsPermission: _contactsPermission,
        spamFolderEnabled: _spamFolderEnabled,
        shareAnonymousData: _shareAnonymousData,
        showDetectionPopup: _showDetectionPopup,
        onChangeDefaultSms: (index) {
          setState(() => _defaultSmsIndex = index);
        },
        onChangeSmsPermission: (v) {
          setState(() => _smsPermission = v);
        },
        onChangeNotificationPermission: (v) {
          setState(() => _notificationPermission = v);
        },
        onChangeContactsPermission: (v) {
          setState(() => _contactsPermission = v);
        },
        onChangeSpamFolder: (v) {
          setState(() => _spamFolderEnabled = v);
        },
        onChangeShareAnonymousData: (v) {
          setState(() => _shareAnonymousData = v);
          widget.onChangeShareAnonymousData(v);
        },
        onChangeShowDetectionPopup: (v) {
          setState(() => _showDetectionPopup = v);
          widget.onChangeShowDetectionPopup(v);
        },
      ),
      backgroundColor: const Color(0xFFF6F4EC),
      body: SafeArea(
        child: Column(
          children: [
            const _TopHeader(),
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
                    icon: Icon(
                      _spamFolderEnabled ? Icons.folder : Icons.folder_off,
                      size: 35,
                    ),
                    color: _spamFolderEnabled
                        ? const Color(0xFF1A7A72)
                        : Colors.grey.withOpacity(.5),
                    onPressed: () {
                      if (_spamFolderEnabled) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SpamFolderPage(),
                          ),
                        );
                      } else {
                        _showCenterNote("Spam Folder is disabled.");
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person, size: 30),
                    color: const Color(0xFF1A7A72),
                    onPressed: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: _SearchBar(),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: messages.length,
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
                    shareAnonymousData: _shareAnonymousData,
                    showDetectionPopup: _showDetectionPopup,
                    onChangeShareAnonymousData: (v) {
                      setState(() => _shareAnonymousData = v);
                      widget.onChangeShareAnonymousData(v);
                    },
                    onChangeShowDetectionPopup: (v) {
                      setState(() => _showDetectionPopup = v);
                      widget.onChangeShowDetectionPopup(v);
                    },
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
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A7A72),
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 16),
      child: const Row(
        children: [
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
                  offset: Offset(0, 2),
                ),
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
                  offset: Offset(0, 2),
                ),
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
  final bool shareAnonymousData;
  final bool showDetectionPopup;
  final ValueChanged<bool> onChangeShareAnonymousData;
  final ValueChanged<bool> onChangeShowDetectionPopup;

  const _MessageCard({
    required this.sender,
    required this.message,
    required this.time,
    required this.isPhishing,
    required this.shareAnonymousData,
    required this.showDetectionPopup,
    required this.onChangeShareAnonymousData,
    required this.onChangeShowDetectionPopup,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor =
    isPhishing ? const Color(0xFFF2554F) : const Color(0xFF06C85E);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LabelDetectionPage(
              sender: sender,
              message: message,
              time: time,
              isPhishing: isPhishing,
              shareAnonymousData: shareAnonymousData,
              showDetectionPopup: showDetectionPopup,
              onChangeShareAnonymousData: onChangeShareAnonymousData,
              onChangeShowDetectionPopup: onChangeShowDetectionPopup,
            ),
          ),
        );
      },
      child: Padding(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
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
                            ),
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
      ),
    );
  }
}