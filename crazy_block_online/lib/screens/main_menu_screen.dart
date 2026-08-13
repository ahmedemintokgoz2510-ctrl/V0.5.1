import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../providers/game_state.dart';
import 'game_screen.dart';
import 'market_screen.dart';
import 'social_screen.dart';
import 'settings_screen.dart';

class MainMenuScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const MainMenuScreen({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _navigateTo(Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    _buildTopBar(),
                    const SizedBox(height: 40),
                    _buildMainButtons(),
                    const SizedBox(height: 40),
                    _buildSecondaryButtons(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gameState.currentPlayer?.name ?? 'Player',
                      style: AppTheme.titleMedium,
                    ),
                    Text(
                      'ID: ${gameState.currentPlayer?.id ?? ''}',
                      style: AppTheme.bodySmall,
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.accentGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.monetization_on,
                          size: 16, color: Colors.black),
                      const SizedBox(width: 4),
                      Text(
                        gameState.currentCoins.toString(),
                        style: AppTheme.labelMedium.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainButtons() {
    return Column(
      children: [
        // Play Button
        _buildLargeButton(
          title: 'PLAY',
          subtitle: 'CLASSIC GAME',
          icon: Icons.play_arrow_rounded,
          iconColor: AppTheme.buttonGreen,
          onPressed: () => _navigateTo(const GameScreen()),
        ),
        const SizedBox(height: 16),
        // Mini Games Button
        _buildLargeButton(
          title: 'MINI',
          subtitle: 'GAMES',
          icon: Icons.games_rounded,
          iconColor: AppTheme.blockOrange,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mini Games - Coming Soon in V1')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSecondaryButtons() {
    return Column(
      children: [
        // Market Row
        Row(
          children: [
            Expanded(
              child: _buildSmallButton(
                icon: Icons.shopping_cart_rounded,
                title: 'MARKET',
                onPressed: () => _navigateTo(const MarketScreen()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSmallButton(
                icon: Icons.people_rounded,
                title: 'SOCIAL',
                onPressed: () => _navigateTo(const SocialScreen()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Settings Row
        Row(
          children: [
            Expanded(
              child: _buildSmallButton(
                icon: Icons.settings_rounded,
                title: 'SETTINGS',
                onPressed: () => _navigateTo(const SettingsScreen()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSmallButton(
                icon: Icons.logout_rounded,
                title: 'LOGOUT',
                onPressed: () {
                  context.read<GameStateProvider>().logout();
                  widget.onLogout();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLargeButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.bgCardLight.withOpacity(0.8),
              AppTheme.bgCardDark.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: iconColor.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 40),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTheme.titleMedium.copyWith(fontSize: 28),
                    ),
                    Text(
                      subtitle,
                      style: AppTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_rounded,
                  color: Colors.white.withOpacity(0.6), size: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallButton({
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.bgCardLight.withOpacity(0.8),
              AppTheme.bgCardDark.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.accentGreen, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTheme.labelMedium.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
