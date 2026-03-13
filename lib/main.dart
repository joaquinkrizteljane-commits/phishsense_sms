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

  @override
  Widget build(BuildContext context) {
    switch (_currentStep) {
      case 0:
        return WelcomePage(
          setupCompleted: _setupCompleted,
          onGetStarted: _showNotice,
          onGoToProfile: () {
            setState(() {
              _currentStep = 6;
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
                Navigator.pop(context);
                setState(() {
                  _smsPermission = true;
                });
                _nextStep();
              },
              onDeny: () {
                Navigator.pop(context);
                setState(() {
                  _smsPermission = false;
                });
                _nextStep();
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
              type: PermissionType.notification,
              onAllow: () {
                Navigator.pop(context);
                setState(() {
                  _notificationPermission = true;
                });
                _nextStep();
              },
              onDeny: () {
                Navigator.pop(context);
                setState(() {
                  _notificationPermission = false;
                });
                _nextStep();
              },
            );
          },
          onBack: _prevStep,
        );

      case 3:
        return Step3Page(
          onContinue: () {
            PermissionPage.show(
              context,
              type: PermissionType.contacts,
              onAllow: () {
                Navigator.pop(context);
                setState(() {
                  _contactsPermission = true;
                  _currentStep = 4;
                });
              },
              onDeny: () {
                Navigator.pop(context);
                setState(() {
                  _contactsPermission = false;
                  _currentStep = 4;
                });
              },
            );
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
        return ProfilePage(
          name: _userName,
          defaultSmsIndex: _defaultSmsIndex,
          smsPermission: _smsPermission,
          notificationPermission: _notificationPermission,
          contactsPermission: _contactsPermission,
          onChangeDefaultSms: (index) {
            setState(() {
              _defaultSmsIndex = index;
            });
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
          onSignOut: _resetFlow,
        );

      default:
        return const Scaffold(
          body: SizedBox(),
        );
    }
  }
}