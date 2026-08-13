import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';
import '../providers/game_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                      _buildProfileSection(),
                      const SizedBox(height: 20),
                      _buildAccountDetailsSection(),
                      const SizedBox(height: 20),
                      _buildSecuritySection(),
                      const SizedBox(height: 20),
                      _buildDangerZone(),
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
            'ACCOUNT',
            style: AppTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        final player = gameState.currentPlayer;
        return AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PROFILE SECTION',
                style: AppTheme.labelMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
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
                          color: AppTheme.primaryBlue.withOpacity(0.5),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        (player?.name.substring(0, 1) ?? 'P')
                            .toUpperCase(),
                        style: AppTheme.titleLarge,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player?.name ?? 'Player',
                          style: AppTheme.bodyLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID: ${player?.id ?? 'N/A'}',
                          style: AppTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountDetailsSection() {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        final player = gameState.currentPlayer;
        return AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACCOUNT DETAILS',
                style: AppTheme.labelMedium,
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Username', player?.name ?? 'N/A', editable: true),
              const SizedBox(height: 12),
              _buildInfoRow('Email', player?.email ?? 'N/A', editable: true),
              const SizedBox(height: 12),
              _buildInfoRow('High Score', '${player?.highScore ?? 0}'),
              const SizedBox(height: 12),
              _buildInfoRow('Coins', '${gameState.currentCoins}'),
              const SizedBox(height: 12),
              _buildInfoRow(
                'Verification Status',
                player?.isVerified ?? false ? 'Verified' : 'Not Verified',
                isVerified: player?.isVerified ?? false,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    bool editable = false,
    bool isVerified = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTheme.bodyMedium),
        Row(
          children: [
            Text(
              value,
              style: AppTheme.bodySmall.copyWith(
                color: isVerified ? AppTheme.buttonGreen : AppTheme.textGrey,
              ),
            ),
            if (editable) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.edit,
                size: 16,
                color: AppTheme.textGrey,
              ),
            ],
            if (isVerified) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.check_circle,
                size: 16,
                color: AppTheme.buttonGreen,
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SECURITY',
            style: AppTheme.labelMedium,
          ),
          const SizedBox(height: 16),
          _buildSecurityButton(
            icon: Icons.lock,
            title: 'Change Password',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password change feature coming soon'),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildSecurityButton(
            icon: Icons.verified_user,
            title: 'Two-Step Verification',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Two-step verification coming soon'),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildSecurityButton(
            icon: Icons.history,
            title: 'Login Activity',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login activity coming soon'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityButton({
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.accentGreen, size: 20),
              const SizedBox(width: 12),
              Text(title, style: AppTheme.bodyMedium),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.6),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZone() {
    return AppCard(
      padding: const EdgeInsets.all(20),
      backgroundColor: AppTheme.buttonRed.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DANGER ZONE',
            style: AppTheme.labelMedium.copyWith(
              color: AppTheme.buttonRed,
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            text: 'DELETE ACCOUNT',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Account?'),
                  content: const Text(
                    'This action cannot be undone. All your data will be permanently deleted.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: AppTheme.buttonRed,
          ),
        ],
      ),
    );
  }
}
