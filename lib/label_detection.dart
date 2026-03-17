import 'package:flutter/material.dart';

class LabelDetectionPage extends StatefulWidget {
  final String sender;
  final String message;
  final String time;
  final bool isPhishing;

  const LabelDetectionPage({
    super.key,
    required this.sender,
    required this.message,
    required this.time,
    required this.isPhishing,
  });

  @override
  State<LabelDetectionPage> createState() => _LabelDetectionPageState();
}

class _LabelDetectionPageState extends State<LabelDetectionPage> {
  bool shareMessage = true;
  bool dontShowAgain = false;
  bool showOverlay = true;

  @override
  Widget build(BuildContext context) {
    final bool isPhishing = widget.isPhishing;

    final Color statusColor =
    isPhishing ? const Color(0xFFD80E0E) : const Color(0xFF46C12F);

    final String statusText =
    isPhishing ? "Phishing Detected" : "Safe Message";

    final String subtitleText = isPhishing
        ? "This message shows signs of a phishing attempt. Do not click links or share personal information."
        : "This message is from a saved contact. However, always remain cautious of suspicious links or requests.";

    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EC),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFF17202A),
                          size: 24,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xFFE4E5EA),
                              child: Icon(
                                Icons.person,
                                size: 32,
                                color: Color(0xFFA8ADB8),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.sender,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF17202A),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isPhishing ? Icons.more_vert : Icons.more_horiz,
                        color: const Color(0xFF17202A),
                        size: 28,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1.2,
                  color: const Color(0xFF204760),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Text(
                    subtitleText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF707070),
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 255,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isPhishing ? "‼️" : "✅",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  "Saturday, December 14",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6C6C6C),
                  ),
                ),
                const SizedBox(height: 22),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              widget.message,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 245),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFECE4D7),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              isPhishing
                                  ? "Mukhang scam yan. Ignore ko na."
                                  : "Okay po, noted ❤️",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 14),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        size: 36,
                        color: Color(0xFF17202A),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0EADB),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: const Text(
                            "Enter your message...",
                            style: TextStyle(
                              color: Color(0xFF32516A),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.send_rounded,
                        size: 34,
                        color: Color(0xFF17202A),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (showOverlay)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF496376).withOpacity(.96),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            isPhishing
                                ? const _PhishingIconWidget()
                                : const _SafeIconWidget(),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Text(
                                  statusText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: shareMessage,
                                    onChanged: (value) {
                                      setState(() {
                                        shareMessage = value ?? false;
                                      });
                                    },
                                    activeColor: const Color(0xFF7DBD52),
                                    materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  const SizedBox(width: 4),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        "Share this message to contribute\nto model improvement",
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          color: Colors.black87,
                                          height: 1.25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 42,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFF0E3550),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "❌ Report as inaccurate",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dontShowAgain = !dontShowAgain;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    dontShowAgain
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    "Do not show this again",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showOverlay = false;
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            size: 34,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SafeIconWidget extends StatelessWidget {
  const _SafeIconWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 86,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.shield,
            size: 82,
            color: Colors.green.shade700,
          ),
          const Icon(
            Icons.check_rounded,
            size: 38,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _PhishingIconWidget extends StatelessWidget {
  const _PhishingIconWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 86,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.warning_rounded,
            size: 82,
            color: Colors.red.shade400,
          ),
          const Positioned(
            top: 18,
            child: Icon(
              Icons.priority_high_rounded,
              size: 38,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}