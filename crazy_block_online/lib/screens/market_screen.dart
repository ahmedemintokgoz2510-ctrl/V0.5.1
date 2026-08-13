import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../providers/game_state.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['BLOCKS', 'BACKGROUNDS', 'GIFS'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTabBar(),
              const SizedBox(height: 20),
              Expanded(
                child: _buildMarketContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Text(
            'MARKET',
            style: AppTheme.titleMedium,
          ),
          Consumer<GameStateProvider>(
            builder: (context, gameState, child) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          _tabs.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = index;
              });
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: _selectedTab == index
                    ? AppTheme.bgCardLight
                    : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: _selectedTab == index
                        ? AppTheme.accentGreen
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _tabs[index],
                style: AppTheme.labelMedium.copyWith(
                  color: _selectedTab == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMarketContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            AppCard(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 60,
                    color: AppTheme.accentGreen.withOpacity(0.6),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Coming Soon',
                    style: AppTheme.titleMedium.copyWith(
                      color: AppTheme.accentGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'New items and cosmetics will be available here in future updates!',
                    style: AppTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.bgCardDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Check back soon for exciting new ${_tabs[_selectedTab].toLowerCase()}!',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.accentGreen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              icon: Icons.info_outline,
              title: 'Market Info',
              description:
                  'The market is where you can customize your game with different block styles, backgrounds, and effects. Earn coins by playing and unlock exclusive items!',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.accentGreen, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppTheme.headingStyle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
