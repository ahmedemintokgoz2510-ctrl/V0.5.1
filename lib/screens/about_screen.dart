import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildLogoSection(),
                      const SizedBox(height: 30),
                      _buildInfoSection(),
                      const SizedBox(height: 20),
                      _buildLegalSection(),
                      const SizedBox(height: 20),
                      _buildCreditsSection(),
                      const SizedBox(height: 30),
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

  Widget _buildHeader(BuildContext context) {
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
            'ABOUT',
            style: AppTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.blockCyan,
                  AppTheme.primaryBlue,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryBlue.withOpacity(0.6),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'CBO',
                style: AppTheme.titleLarge.copyWith(
                  fontSize: 36,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'CRAZY BLOCK ONLINE',
            style: AppTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Version 0.5.0',
            style: AppTheme.headingStyle,
          ),
          const SizedBox(height: 4),
          Text(
            '© 2026 Crazy Block Online',
            style: AppTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ABOUT THE GAME',
            style: AppTheme.labelMedium,
          ),
          const SizedBox(height: 12),
          Text(
            'Crazy Block Online is a colorful and competitive block puzzle game with classic gameplay, online matches, rankings, customization, and additional mini-games.',
            style: AppTheme.bodySmall,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.bgCardDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Features:',
                  style: AppTheme.labelMedium,
                ),
                const SizedBox(height: 8),
                _buildFeatureItem('Classic Block Puzzle Gameplay'),
                _buildFeatureItem('Online Multiplayer Matches'),
                _buildFeatureItem('Global Leaderboards'),
                _buildFeatureItem('Customizable Game Themes'),
                _buildFeatureItem('Mini Games'),
                _buildFeatureItem('Social Features & Friends'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: AppTheme.accentGreen,
          ),
          const SizedBox(width: 8),
          Text(
            feature,
            style: AppTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildLegalSection() {
    return Column(
      children: [
        _buildLegalButton('Terms of Service'),
        const SizedBox(height: 12),
        _buildLegalButton('Privacy Policy'),
        const SizedBox(height: 12),
        _buildLegalButton('Support'),
      ],
    );
  }

  Widget _buildLegalButton(String title) {
    return GestureDetector(
      onTap: () {},
      child: AppCard(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.bodyLarge,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.white.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditsSection() {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CREDITS',
            style: AppTheme.labelMedium,
          ),
          const SizedBox(height: 12),
          Text(
            'Made by Zodiac',
            style: AppTheme.bodyLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'A passion project built with Flutter and love for puzzle games.',
            style: AppTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialButton(Icons.language, 'Website'),
              _buildSocialButton(Icons.email, 'Email'),
              _buildSocialButton(Icons.bookmark, 'More Apps'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.bgCardLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.bgCardLight,
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: AppTheme.accentGreen,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
