import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/constant.dart';
import 'package:david_psalmist/core/widgets/custom_alert_dialoge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isArabic = false;
  bool _didInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInit) {
      _isArabic =
          context.locale.languageCode == ConstantVariable.arabicLangCode;
      _didInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings".tr())),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Arabic Row
                  _buildLanguageRow(ConstantVariable.arabicLangCode, 'العربية'),
                  const SizedBox(height: 20),
                  // English Row
                  _buildLanguageRow(
                    ConstantVariable.englishLangCode,
                    'English',
                  ),
                  const SizedBox(height: 20),
                  // Logout Row
                  Row(
                    children: [
                      const Icon(LucideIcons.logOut, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Logout".tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () {
                            showDialog(
                              barrierColor: ColorsTheme().grayWhite.withValues(
                                alpha: 0.3,
                              ),
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                title: 'Logout',
                                content: 'Are you sure you want to logout?',
                                nameOfNegativeButton: 'Cancel',
                                nameOfPositiveButton: 'Logout',
                                onNegativeButtonPressed: () =>
                                    Navigator.pop(context),
                                onPositiveButtonPressed: () async {},
                              ),
                            );
                          },
                          child: Text(
                            "Logout".tr(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageRow(String locale, String label) {
    final isActive = _isArabic
        ? locale == ConstantVariable.arabicLangCode
        : locale == ConstantVariable.englishLangCode;
    return Row(
      children: [
        Icon(LucideIcons.globe, color: ColorsTheme().primaryDark),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.styleBold20sp(
              context,
            ).copyWith(color: ColorsTheme().primaryDark),
          ),
        ),
        FlutterSwitch(
          width: 60.0,
          height: 30.0,
          value: isActive,
          activeColor: ColorsTheme().primaryDark,
          inactiveColor: Colors.grey[300]!,
          toggleColor: Colors.white,
          borderRadius: 20,
          showOnOff: false,
          onToggle: (value) {
            setState(() {
              _isArabic = locale == ConstantVariable.arabicLangCode;
            });
            context.setLocale(Locale(locale));
          },
        ),
      ],
    );
  }
}
