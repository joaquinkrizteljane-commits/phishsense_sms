import 'package:flutter/material.dart';
import 'welcome.dart';
import 'notice.dart';
import 'step1.dart';
import 'step2.dart';
import 'step3.dart';
import 'permission.dart';
import 'default_sms.dart';
import 'name_page.dart';
import 'profile.dart';
import 'messages.dart';
import 'error.dart';
import 'sync.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhishSense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A7A72),
          primary: const Color(0xFF1A7A72),
          secondary: const Color(0xFFE0A800),
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const AppFlow(),
    );
  }
}

class AppFlow extends StatefulWidget {
  const AppFlow({super.key});

  @override
  State<AppFlow> createState() => _AppFlowState();
}

class _AppFlowState extends State<AppFlow> {
  int _currentStep = 0;
  int _defaultSmsIndex = 1;

  bool _setupCompleted = false;
  bool _smsPermission = false;
  bool _notificationPermission = false;
  bool _contactsPermission = false;
  bool _spamFolderEnabled = false;

  String _userName = "";

  void _nextStep() {
    setState(() => _currentStep++);
  }

  void _prevStep() {
    setState(() {
      if (_currentStep > 0) _currentStep--;
    });
  }

  void _resetFlow() {
    setState(() {
      _currentStep = 0;
      _defaultSmsIndex = 1;
      _setupCompleted = false;
      _smsPermission = false;
      _notificationPermission = false;
      _contactsPermission = false;
      _spamFolderEnabled = false;
      _userName = "";
    });
  }

  void _showNotice() {
    NoticeDialog.show(
      context,
      onAccept: () {
        Navigator.pop(context);
        _nextStep();
      },
      onClose: () {
        Navigator.pop(context);
        _resetFlow();
      },
    );
  }

  void _showSmsError() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      ErrorPage.show(
        context,
        title: "SMS Access Required",
        message:
        "You cannot continue unless SMS access is allowed because PhishSense needs to scan messages for phishing.",
      );
    });
  }

  void _showContactsError() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      ErrorPage.show(
        context,
        title: "Contacts Access Required",
        message:
        "You cannot continue unless Contacts access is allowed because PhishSense uses trusted contacts to reduce false phishing alerts.",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentStep) {
      case 0:
        return WelcomePage(
          setupCompleted: _setupCompleted,
          onGetStarted: _showNotice,
          onGoToProfile: () {
            setState(() {
              _currentStep = 8;
            });
          },
        );

      case 1:
        return Step1Page(
          onContinue: () {
            PermissionPage.show(
              context,
              type: PermissionType.sms,
              onAllow: () {
                setState(() {
                  _smsPermission = true;
                });
                _nextStep();
              },
              onDeny: () {
                setState(() {
                  _smsPermission = false;
                });
                _showSmsError();
              },
            );
          },
          onBack: _resetFlow,
        );

      case 2:
        return Step2Page(
          onContinue: () {
            PermissionPage.show(
              context,
              type: PermissionType.contacts,
              onAllow: () {
                setState(() {
                  _contactsPermission = true;
                });
                _nextStep();
              },
              onDeny: () {
                setState(() {
                  _contactsPermission = false;
                });
                _showContactsError();
              },
            );
          },
          onBack: _prevStep,
        );

      case 3:
        return Step3Page(
          onAllow: () {
            setState(() {
              _notificationPermission = true;
              _currentStep = 4;
            });
          },
          onSkip: () {
            setState(() {
              _notificationPermission = false;
              _currentStep = 4;
            });
          },
          onBack: _prevStep,
        );

      case 4:
        return NamePage(
          onContinue: (name) {
            setState(() {
              _userName = name;
              _currentStep = 5;
            });
          },
        );

      case 5:
        return DefaultSmsPage(
          initialIndex: _defaultSmsIndex,
          onSetDefault: (index) {
            setState(() {
              _defaultSmsIndex = index;
              _setupCompleted = true;
              _currentStep = 6;
            });
          },
        );

      case 6:
        return SyncPage(
          onDone: () {
            if (!mounted) return;
            setState(() {
              _currentStep = 7;
            });
          },
        );

      case 7:
        return MessagesPage(
          name: _userName,
          defaultSmsIndex: _defaultSmsIndex,
          smsPermission: _smsPermission,
          notificationPermission: _notificationPermission,
          contactsPermission: _contactsPermission,
          spamFolderEnabled: _spamFolderEnabled,
        );

      case 8:
        return ProfileSidebar(
          name: _userName,
          defaultSmsIndex: _defaultSmsIndex,
          smsPermission: _smsPermission,
          notificationPermission: _notificationPermission,
          contactsPermission: _contactsPermission,
          spamFolderEnabled: _spamFolderEnabled,
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
          onChangeSpamFolder: (bool value) {
            setState(() => _spamFolderEnabled = value);
          },
        );

      default:
        return const Scaffold(
          body: Center(
            child: Text("Something went wrong."),
          ),
        );
    }
  }
}