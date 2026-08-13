import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoadingScreen extends StatefulWidget {
  final VoidCallback onLoadingComplete;

  const LoadingScreen({
    Key? key,
    required this.onLoadingComplete,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startLoadingDelay();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      6,
      (index) => AnimationController(
        duration: Duration(milliseconds: 800 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(0, -2),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    }).toList();

    for (var controller in _controllers) {
      controller.repeat(reverse: true);
    }
  }

  void _startLoadingDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onLoadingComplete();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.bgGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Animated blocks around title
              SizedBox(
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Top left block
                    Positioned(
                      top: 0,
                      left: 20,
                      child: SlideTransition(
                        position: _animations[0],
                        child: _buildBlock(
                          AppTheme.blockCyan,
                          AppTheme.blockBlue,
                        ),
                      ),
                    ),
                    // Top right blocks
                    Positioned(
                      top: 0,
                      right: 20,
                      child: SlideTransition(
                        position: _animations[1],
                        child: _buildBlock(
                          AppTheme.blockOrange,
                          AppTheme.blockRed,
                        ),
                      ),
                    ),
                    // Title in center
                    _buildTitle(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Animated block rows
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _animations[2],
                    child: _buildBlock(AppTheme.blockRed, Colors.red),
                  ),
                  const SizedBox(width: 8),
                  SlideTransition(
                    position: _animations[3],
                    child: _buildBlock(AppTheme.blockOrange, Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _animations[4],
                    child: _buildBlock(AppTheme.blockGreen, Colors.green),
                  ),
                  const SizedBox(width: 8),
                  SlideTransition(
                    position: _animations[5],
                    child: _buildBlock(
                      AppTheme.blockPurple,
                      Colors.purple,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Loading...',
                style: AppTheme.bodyLarge.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    minHeight: 4,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation(
                      AppTheme.accentGreen,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Made by Zodiac',
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'CRAZY',
            style: AppTheme.titleLarge.copyWith(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: AppTheme.accentGreen,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          Text(
            'BLOCK',
            style: AppTheme.titleLarge.copyWith(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: AppTheme.primaryCyan,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
          Text(
            'ONLINE',
            style: AppTheme.bodyLarge.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlock(Color color1, Color color2) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.6),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
