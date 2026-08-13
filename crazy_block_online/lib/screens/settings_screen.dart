import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../providers/game_state.dart';
import 'account_screen.dart';
import 'language_screen.dart';
import 'about_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildAudioSettings(),
                      const SizedBox(height: 16),
                      _buildNavigationSettings(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.bgCardLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'SETTINGS',
            style: AppTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildAudioSettings() {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.bgCardLight.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.bgCardLight,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSettingRow(
                  icon: Icons.music_note,
                  title: 'MUSIC',
                  value: gameState.isMusicOn,
                  onChanged: (_) => gameState.toggleMusic(),
                ),
                const Divider(color: Colors.white12, height: 20),
                _buildSettingRow(
                  icon: Icons.volume_up,
                  title: 'SOUND EFFECTS',
                  value: gameState.isSfxOn,
                  onChanged: (_) => gameState.toggleSfx(),
                ),
                const Divider(color: Colors.white12, height: 20),
                _buildSettingRow(
                  icon: Icons.notifications,
                  title: 'NOTIFICATIONS',
                  value: gameState.notificationsOn,
                  onChanged: (_) => gameState.toggleNotifications(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.accentGreen, size: 24),
            const SizedBox(width: 12),
            Text(title, style: AppTheme.headingStyle),
          ],
        ),
        Consumer<GameStateProvider>(
          builder: (context, gameState, child) {
            bool toggleValue = value;
            if (title == 'MUSIC') toggleValue = gameState.isMusicOn;
            if (title == 'SOUND EFFECTS') toggleValue = gameState.isSfxOn;
            if (title == 'NOTIFICATIONS') toggleValue = gameState.notificationsOn;

            return GestureDetector(
              onTap: () => onChanged(!toggleValue),
              child: Container(
                width: 60,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: toggleValue
                      ? AppTheme.buttonGreen
                      : AppTheme.buttonRed,
                  boxShadow: [
                    BoxShadow(
                      color: (toggleValue
                              ? AppTheme.buttonGreen
                              : AppTheme.buttonRed)
                          .withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: toggleValue ? 30 : 4,
                      top: 4,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNavigationSettings() {
    return Column(
      children: [
        _buildSettingButton(
          icon: Icons.person,
          title: 'ACCOUNT',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildSettingButton(
          icon: Icons.people,
          title: 'SOCIAL',
          badge: '3',
          onPressed: () {
            // Navigate to social from settings
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 12),
        _buildSettingButton(
          icon: Icons.language,
          title: 'LANGUAGE',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LanguageScreen()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildSettingButton(
          icon: Icons.info,
          title: 'ABOUT',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSettingButton({
    required IconData icon,
    required String title,
    String? badge,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.bgCardLight.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.bgCardLight,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppTheme.accentGreen, size: 28),
                const SizedBox(width: 12),
                Text(title, style: AppTheme.headingStyle),
                if (badge != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.buttonRed,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge,
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.6),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
