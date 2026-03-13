import 'package:flutter/material.dart';
import 'default_sms.dart';
import 'messages.dart';
import 'permission.dart';
import 'privacy_policy.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback? onSignOut;
  final int defaultSmsIndex;
  final bool smsPermission;
  final bool notificationPermission;
  final bool contactsPermission;
  final Function(int) onChangeDefaultSms;
  final Function(bool) onChangeSmsPermission;
  final Function(bool) onChangeNotificationPermission;
  final Function(bool) onChangeContactsPermission;
  final String name;

  const ProfilePage({
    super.key,
    this.onSignOut,
    required this.defaultSmsIndex,
    required this.smsPermission,
    required this.notificationPermission,
    required this.contactsPermission,
    required this.onChangeDefaultSms,
    required this.onChangeSmsPermission,
    required this.onChangeNotificationPermission,
    required this.onChangeContactsPermission,
    required this.name,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _name;
  String _avatar = "👨‍💻";
  DateTime? _lastUpdate;

  bool _spamFolder = false;
  bool _shareData = false;

  final List<String> _avatars = [
    "👨‍💻",
    "👩‍💻",
    "👨‍⚕️",
    "👩‍⚕️",
    "👨‍🏫",
    "👩‍🏫",
    "👨‍🍳",
    "👩‍🍳",
    "👨‍🔬",
    "👩‍🔬",
    "👨‍🎨",
    "👩‍🎨",
    "👨‍🚀",
    "👩‍🚀",
    "👨‍✈️",
    "👩‍✈️",
  ];

  @override
  void initState() {
    super.initState();
    _name = widget.name;
  }

  bool get _canEdit {
    if (_lastUpdate == null) return true;
    return DateTime.now().difference(_lastUpdate!) >= const Duration(days: 7);
  }

  void _signOut() {
    widget.onSignOut?.call();
  }

  void _blockedMessage() {
    if (_lastUpdate == null) return;

    final remaining = 7 - DateTime.now().difference(_lastUpdate!).inDays;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "You can update your profile again in $remaining day(s).",
        ),
      ),
    );
  }

  void _editName() {
    if (!_canEdit) {
      _blockedMessage();
      return;
    }

    final controller = TextEditingController(text: _name);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Name"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter your name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (controller.text.trim().isNotEmpty) {
                  _name = controller.text.trim();
                }
                _lastUpdate = DateTime.now();
              });

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _editAvatar() {
    if (!_canEdit) {
      _blockedMessage();
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (_) => GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        itemCount: _avatars.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            setState(() {
              _avatar = _avatars[i];
              _lastUpdate = DateTime.now();
            });

            Navigator.pop(context);
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF1A7A72).withOpacity(0.15),
            child: Text(
              _avatars[i],
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _row({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return ListTile(
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF1A7A72),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Opacity(opacity: enabled ? 1.0 : 0.5, child: Text(title)),
      subtitle: subtitle != null
          ? Opacity(opacity: enabled ? 1.0 : 0.5, child: Text(subtitle))
          : null,
      trailing: trailing,
      onTap: enabled ? onTap : null,
    );
  }

  Future<void> _requestPermissionIfNeeded(
      PermissionType type, VoidCallback onGranted) async {
    bool hasPermission = false;

    switch (type) {
      case PermissionType.sms:
        hasPermission = widget.smsPermission;
        break;

      case PermissionType.notification:
        hasPermission = widget.notificationPermission;
        break;

      case PermissionType.contacts:
        hasPermission = widget.contactsPermission;
        break;
    }

    if (!hasPermission) {
      PermissionPage.show(
        context,
        type: type,
        onAllow: () {
          switch (type) {
            case PermissionType.sms:
              widget.onChangeSmsPermission(true);
              break;

            case PermissionType.notification:
              widget.onChangeNotificationPermission(true);
              break;

            case PermissionType.contacts:
              widget.onChangeContactsPermission(true);
              break;
          }

          Navigator.pop(context);
          onGranted();
        },
        onDeny: () {
          Navigator.pop(context);
        },
      );
    } else {
      onGranted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(
                      Icons.phishing,
                      size: MediaQuery.of(context).size.width * 0.08,
                      color: const Color(0xFF888880),
                    ),
                    const SizedBox(width: 8),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Phish',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A7A72),
                            ),
                          ),
                          TextSpan(
                            text: 'Sense',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE0A800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor:
                    const Color(0xFF1A7A72).withOpacity(0.15),
                    child: Text(
                      _avatar,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  GestureDetector(
                    onTap: _editAvatar,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0A800),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: _editName,
                    child: const Icon(
                      Icons.edit,
                      size: 18,
                      color: Color(0xFF1A7A72),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _row(
                icon: Icons.phone,
                title: "+63 974 081 9667",
                subtitle: "Phone Number",
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MessagesPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0A800).withOpacity(0.65),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.sms),
                  label: const Text(
                    "Open Messages",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              _sectionTitle("Settings"),

              _row(
                icon: Icons.sms,
                title: "Change Default SMS App",
                subtitle: widget.defaultSmsIndex == 0
                    ? "PhishSense"
                    : "Messages",
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: Color(0xFF1A7A72), size: 18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DefaultSmsPage(
                        initialIndex: widget.defaultSmsIndex,
                        onSetDefault: (index) {
                          widget.onChangeDefaultSms(index);
                          Navigator.pop(context); // return to profile
                        },
                      ),
                    ),
                  );
                },
              ),

              _row(
                icon: Icons.notifications_active,
                title: "Notification Permission",
                subtitle: "Allow phishing alerts",
                trailing: Switch(
                  value: widget.notificationPermission,
                  activeColor: const Color(0xFF1A7A72),
                  onChanged: (v) {
                    if (v) {
                      _requestPermissionIfNeeded(
                        PermissionType.notification,
                            () => widget.onChangeNotificationPermission(true),
                      );
                    } else {
                      widget.onChangeNotificationPermission(false);
                    }
                  },
                ),
              ),

              _row(
                icon: Icons.contacts,
                title: "Contacts Permission",
                subtitle: "Detect known senders",
                trailing: Switch(
                  value: widget.contactsPermission,
                  activeColor: const Color(0xFF1A7A72),
                  onChanged: (v) {
                    if (v) {
                      _requestPermissionIfNeeded(
                        PermissionType.contacts,
                            () => widget.onChangeContactsPermission(true),
                      );
                    } else {
                      widget.onChangeContactsPermission(false);
                    }
                  },
                ),
              ),

              _row(
                icon: Icons.warning,
                title: "Enable Phishing Detection",
                subtitle: "Automatically scan incoming messages",
                trailing: Switch(
                  value: widget.smsPermission,
                  activeColor: const Color(0xFF1A7A72),
                  onChanged: (v) {
                    if (v) {
                      _requestPermissionIfNeeded(
                        PermissionType.sms,
                            () => widget.onChangeSmsPermission(true),
                      );
                    } else {
                      widget.onChangeSmsPermission(false);
                    }
                  },
                ),
              ),

              _row(
                icon: Icons.folder,
                title: "Spam Management",
                subtitle: "Move detected messages to spam folder",
                trailing: Switch(
                  value: _spamFolder,
                  activeColor: const Color(0xFF1A7A72),
                  onChanged: (v) => setState(() => _spamFolder = v),
                ),
              ),

              _row(
                icon: Icons.mobile_screen_share_outlined,
                title: "Share Anonymous Data",
                subtitle: "Help improve phishing detection accuracy",
                trailing: Switch(
                  value: _shareData,
                  activeColor: const Color(0xFF1A7A72),
                  onChanged: (v) => setState(() => _shareData = v),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _signOut,
                      child: Row(
                        children: const [
                          Icon(Icons.logout, color: Color(0xFF1A7A72)),
                          SizedBox(width: 6),
                          Text(
                            "Sign Out",
                            style: TextStyle(
                              color: Color(0xFF1A7A72),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        PrivacyPolicyDialog.show(context);
                      },
                      child: const Text(
                        "Privacy & Policy",
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}