import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'permission.dart';
import 'privacy_policy.dart';

class ProfileSidebar extends StatefulWidget {
  final int defaultSmsIndex;
  final bool smsPermission;
  final bool notificationPermission;
  final bool contactsPermission;
  final bool spamFolderEnabled;

  final Function(int) onChangeDefaultSms;
  final Function(bool) onChangeSmsPermission;
  final Function(bool) onChangeNotificationPermission;
  final Function(bool) onChangeContactsPermission;
  final Function(bool) onChangeSpamFolder;

  final String name;

  const ProfileSidebar({
    super.key,
    required this.defaultSmsIndex,
    required this.smsPermission,
    required this.notificationPermission,
    required this.contactsPermission,
    required this.spamFolderEnabled,
    required this.onChangeDefaultSms,
    required this.onChangeSmsPermission,
    required this.onChangeNotificationPermission,
    required this.onChangeContactsPermission,
    required this.onChangeSpamFolder,
    required this.name,
  });

  @override
  State<ProfileSidebar> createState() => _ProfileSidebarState();
}

class _ProfileSidebarState extends State<ProfileSidebar> {
  late String _name;
  String _avatar = "👨‍💻";
  DateTime? _lastUpdate;
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
              color: const Color(0xFFF6F4EC),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(.8),
                  offset: const Offset(-4, -4),
                  blurRadius: 8,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(.15),
                  offset: const Offset(4, 4),
                  blurRadius: 10,
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

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).maybePop();
    });
  }

  Future<bool> _confirm(String title, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _editName() {
    if (!_canEdit) {
      _showCenterNote("You can update your profile again in 7 days.");
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
                _name = controller.text.trim().isEmpty ? _name : controller.text.trim();
                _lastUpdate = DateTime.now();
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  void _editAvatar() {
    showModalBottomSheet(
      context: context,
      builder: (_) => GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        shrinkWrap: true,
        itemCount: _avatars.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            setState(() => _avatar = _avatars[i]);
            Navigator.pop(context);
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF1A7A72).withOpacity(.12),
            child: Text(
              _avatars[i],
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
      ),
    );
  }

  Widget _row({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
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
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .88,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF6F4EC),
              Color(0xFFF2ECE1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.horizontal(left: Radius.circular(24)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
          child: Stack(
            children: [
              const Positioned.fill(
                child: _SidebarSoftBackground(),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Account",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                  const Color(0xFF1A7A72).withOpacity(.15),
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
                                    child: const Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    _name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
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
                              icon: Icons.notifications_active,
                              title: "Notification Permission",
                              subtitle: "Allow phishing alerts",
                              trailing: Switch(
                                value: widget.notificationPermission,
                                activeColor: const Color(0xFF1A7A72),
                                onChanged: widget.onChangeNotificationPermission,
                              ),
                            ),
                            _row(
                              icon: Icons.contacts,
                              title: "Contacts Permission",
                              subtitle: "Detect known senders",
                              trailing: Switch(
                                value: widget.contactsPermission,
                                activeColor: const Color(0xFF1A7A72),
                                onChanged: (_) {
                                  _showCenterNote("Contacts permission cannot be turned off.");
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
                                onChanged: (_) {
                                  _showCenterNote("Phishing detection cannot be disabled.");
                                },
                              ),
                            ),
                            _row(
                              icon: Icons.folder,
                              title: "Spam Management",
                              subtitle: "Move detected messages to spam folder",
                              trailing: Switch(
                                value: widget.spamFolderEnabled,
                                activeColor: const Color(0xFF1A7A72),
                                onChanged: (v) async {
                                  if (v) {
                                    final ok = await _confirm(
                                      "Enable Spam Folder",
                                      "Detected phishing messages will appear in the Spam Folder.",
                                    );
                                    if (ok) {
                                      widget.onChangeSpamFolder(true);
                                      _showCenterNote("Spam Folder enabled.");
                                    }
                                  } else {
                                    widget.onChangeSpamFolder(false);
                                    _showCenterNote("Spam Folder disabled.");
                                  }
                                },
                              ),
                            ),
                            _row(
                              icon: Icons.mobile_screen_share_outlined,
                              title: "Share Anonymous Data",
                              subtitle: "Help improve phishing detection accuracy",
                              trailing: Switch(
                                value: _shareData,
                                activeColor: const Color(0xFF1A7A72),
                                onChanged: (v) {
                                  setState(() => _shareData = v);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarSoftBackground extends StatelessWidget {
  const _SidebarSoftBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _SoftTexturePainter(),
      ),
    );
  }
}

class _SoftTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final teal = const Color(0xFF1A7A72).withOpacity(0.05);
    final gold = const Color(0xFFE0A800).withOpacity(0.035);

    void drawBlurBlob({
      required Offset center,
      required double radius,
      required Color color,
      required double blur,
    }) {
      final paint = Paint()
        ..color = color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

      canvas.drawCircle(center, radius, paint);
    }

    void drawSoftArc({
      required Rect rect,
      required double startAngle,
      required double sweepAngle,
      required Color color,
      required double strokeWidth,
      required double blur,
    }) {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }

    drawBlurBlob(
      center: Offset(size.width * 0.15, size.height * 0.22),
      radius: size.width * 0.20,
      color: teal,
      blur: 30,
    );

    drawBlurBlob(
      center: Offset(size.width * 0.82, size.height * 0.18),
      radius: size.width * 0.16,
      color: gold,
      blur: 28,
    );

    drawBlurBlob(
      center: Offset(size.width * 0.72, size.height * 0.62),
      radius: size.width * 0.24,
      color: teal,
      blur: 36,
    );

    drawBlurBlob(
      center: Offset(size.width * 0.28, size.height * 0.82),
      radius: size.width * 0.22,
      color: gold,
      blur: 34,
    );

    drawSoftArc(
      rect: Rect.fromCircle(
        center: Offset(size.width * 0.92, size.height * 0.92),
        radius: size.width * 0.42,
      ),
      startAngle: 3.7,
      sweepAngle: 1.6,
      color: teal.withOpacity(0.08),
      strokeWidth: 28,
      blur: 14,
    );

    drawSoftArc(
      rect: Rect.fromCircle(
        center: Offset(size.width * 0.95, size.height * 0.95),
        radius: size.width * 0.30,
      ),
      startAngle: 3.9,
      sweepAngle: 1.45,
      color: gold.withOpacity(0.06),
      strokeWidth: 18,
      blur: 10,
    );

    drawSoftArc(
      rect: Rect.fromCircle(
        center: Offset(size.width * 0.05, size.height * 0.10),
        radius: size.width * 0.35,
      ),
      startAngle: 5.2,
      sweepAngle: 1.2,
      color: teal.withOpacity(0.05),
      strokeWidth: 22,
      blur: 12,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}