import 'package:flutter/material.dart';

class NoticeDialog extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onClose;

  const NoticeDialog({
    super.key,
    required this.onAccept,
    required this.onClose,
  });

  static Future<void> show(
      BuildContext context, {
        required VoidCallback onAccept,
        required VoidCallback onClose,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => NoticeDialog(
        onAccept: onAccept,
        onClose: onClose,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A7A72).withOpacity(0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.privacy_tip_outlined,
                    color: Color(0xFF1A7A72),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Data Usage Notice',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onClose,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Scrollable content
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 280),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'At PhishSense, your privacy is our highest priority. Below is a transparent summary of how we handle your data.',
                      style:
                      TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.5),
                    ),
                    const SizedBox(height: 14),
                    _DataPointRow(
                      number: '1',
                      title: 'SMS Messages',
                      detail:
                      'We scan your incoming SMS messages locally on-device to detect phishing attempts. No messages are stored or transmitted.',
                    ),
                    const SizedBox(height: 10),
                    _DataPointRow(
                      number: '2',
                      title: 'Contacts',
                      detail:
                      'Your contacts list is used to verify known senders. This data stays on your device and is never uploaded to our servers.',
                    ),
                    const SizedBox(height: 10),
                    _DataPointRow(
                      number: '3',
                      title: 'Threat Analysis',
                      detail:
                      'Anonymized threat pattern data may be submitted to improve detection models. No personally identifiable information is included.',
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A7A72).withOpacity(0.07),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.lock_outline,
                              size: 16, color: Color(0xFF1A7A72)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'All sensitive data is processed locally. We do not sell or share your personal information with third parties.',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                  height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Accept Button
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A7A72),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'I Understand & Accept',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            const SizedBox(height: 10),
            Center(
              child: Text(
                'You can review this anytime in Settings → Privacy & Policy',
                style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataPointRow extends StatelessWidget {
  final String number;
  final String title;
  final String detail;

  const _DataPointRow({
    required this.number,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: const Color(0xFFE0A800),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A)),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style:
                TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
