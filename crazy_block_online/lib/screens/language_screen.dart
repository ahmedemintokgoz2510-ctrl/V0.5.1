import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../providers/game_state.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<String> _languages = [
    'English',
    'Türkçe',
    'Deutsch',
    'Español',
    'Français',
    'Português',
    'Italiano',
    'Русский',
    'العربية',
    '中文',
    '日本語',
    '한국어',
  ];

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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        AppCard(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            children: List.generate(
                              _languages.length,
                              (index) => _buildLanguageOption(
                                _languages[index],
                                index,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppCard(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: AppTheme.accentGreen,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Language Info',
                                    style: AppTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Language changes will apply throughout the game. All UI text and game content will be displayed in your selected language.',
                                style: AppTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
            'LANGUAGE',
            style: AppTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language, int index) {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        final isSelected = gameState.selectedLanguage == language;
        return GestureDetector(
          onTap: () {
            gameState.setLanguage(language);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Language changed to $language'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.bgCardLight.withOpacity(0.5)
                  : Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: isSelected
                          ? AppTheme.accentGreen
                          : Colors.white.withOpacity(0.6),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      language,
                      style: AppTheme.bodyLarge.copyWith(
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.7),
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: AppTheme.accentGreen,
                    size: 24,
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
