import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../providers/game_state.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    // Reset score for new game
    Future.microtask(() {
      context.read<GameStateProvider>().resetGameScore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildGameHeader(),
                  const SizedBox(height: 20),
                  _buildGameBoard(),
                  const SizedBox(height: 20),
                  _buildGameControls(),
                  const SizedBox(height: 20),
                  _buildNextPieces(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameHeader() {
    return Row(
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                )
              ],
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Column(
          children: [
            Consumer<GameStateProvider>(
              builder: (context, gameState, child) {
                return Column(
                  children: [
                    Text(
                      gameState.currentScore.toString(),
                      style: AppTheme.titleMedium.copyWith(
                        color: AppTheme.accentGreen,
                      ),
                    ),
                    Text(
                      'BEST: ${gameState.currentPlayer?.highScore ?? 0}',
                      style: AppTheme.bodySmall,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.bgCardLight,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                )
              ],
            ),
            child: const Icon(
              Icons.pause,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGameBoard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: Border.all(
          color: AppTheme.bgCardLight,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            childAspectRatio: 1,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: 64,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                border: Border.all(
                  color: AppTheme.bgCardLight,
                  width: 1,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGameControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppButton(
          text: 'UNDO',
          onPressed: () {},
          width: 100,
          height: 48,
          textStyle: AppTheme.labelMedium.copyWith(fontSize: 12),
          backgroundColor: AppTheme.bgCardLight,
        ),
        AppButton(
          text: 'REFRESH',
          onPressed: () {
            context.read<GameStateProvider>().resetGameScore();
            setState(() {});
          },
          width: 100,
          height: 48,
          textStyle: AppTheme.labelMedium.copyWith(fontSize: 12),
          backgroundColor: AppTheme.bgCardLight,
        ),
        AppButton(
          text: 'HINT',
          onPressed: () {},
          width: 100,
          height: 48,
          textStyle: AppTheme.labelMedium.copyWith(fontSize: 12),
          backgroundColor: AppTheme.bgCardLight,
        ),
      ],
    );
  }

  Widget _buildNextPieces() {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NEXT PIECES',
            style: AppTheme.labelMedium,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNextPiecePreview(AppTheme.blockCyan, AppTheme.blockBlue),
              _buildNextPiecePreview(AppTheme.blockOrange, AppTheme.blockRed),
              _buildNextPiecePreview(AppTheme.blockGreen, Colors.green),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Place pieces on the board to clear lines and earn points!',
            style: AppTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'GAME OVER - RESTART',
            onPressed: () {
              context.read<GameStateProvider>().resetGameScore();
              setState(() {});
            },
            gradient: AppTheme.buttonGradient,
          ),
        ],
      ),
    );
  }

  Widget _buildNextPiecePreview(Color color1, Color color2) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.6),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
