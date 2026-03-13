import 'package:flutter/material.dart';

enum PermissionType { sms, notification, contacts }

class PermissionPage extends StatelessWidget {
  final PermissionType type;
  final VoidCallback onAllow;
  final VoidCallback onDeny;

  const PermissionPage({
    super.key,
    required this.type,
    required this.onAllow,
    required this.onDeny,
  });

  static Future<void> show(
      BuildContext context, {
        required PermissionType type,
        required VoidCallback onAllow,
        required VoidCallback onDeny,
      }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFFF2F2F2),
      isScrollControlled: true,
      builder: (_) => PermissionPage(
        type: type,
        onAllow: onAllow,
        onDeny: onDeny,
      ),
    );
  }

  _PermissionContent get _content {
    switch (type) {
      case PermissionType.sms:
        return _PermissionContent(
          icon: Icons.sms_outlined,
          iconColor: const Color(0xFF1A7A72),
          title: 'Allow SMS Access',
          description:
          'PhishSense needs to read your incoming SMS messages to analyze and detect potential phishing threats in real-time.',
        );
      case PermissionType.notification:
        return _PermissionContent(
          icon: Icons.notifications_outlined,
          iconColor: const Color(0xFFE0A800),
          title: 'Allow Notifications',
          description:
          'PhishSense will send you instant alerts when a suspicious message is detected, even when the app is in the background.',
        );
      case PermissionType.contacts:
        return _PermissionContent(
          icon: Icons.contacts_outlined,
          iconColor: const Color(0xFF1A7A72),
          title: 'Allow Contacts Access',
          description:
          'PhishSense uses your contacts list to identify trusted senders and reduce false positives in threat detection.',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _content;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 24),

          // Icon
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: content.iconColor.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(content.icon, size: 40, color: content.iconColor),
          ),
          const SizedBox(height: 20),

          // App name badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Phish',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A7A72),
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: 'Sense',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE0A800),
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: ' is requesting permission',
                      style: TextStyle(
                        color: Color(0xFF888880),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Title
          Text(
            content.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          // Description
          Text(
            content.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // Allow Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onAllow,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A7A72),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Allow',
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Deny Button
          SizedBox(
            width: double.infinity,
            height: 52,
              child: OutlinedButton(
                onPressed: onDeny,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey[600],
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Not Now',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PermissionContent {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  _PermissionContent({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });
}
