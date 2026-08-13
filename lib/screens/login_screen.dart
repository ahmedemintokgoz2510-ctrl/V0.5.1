import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../providers/game_state.dart';
import 'create_account_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginScreen({
    Key? key,
    required this.onLoginSuccess,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simple validation - in real app would authenticate with backend
      final gameState = context.read<GameStateProvider>();
      // For V0.5, create a guest account with entered email
      gameState.initializePlayer(
        _emailController.text.split('@').first,
        _emailController.text,
      );
      widget.onLoginSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'LOGIN',
                    style: AppTheme.titleLarge.copyWith(fontSize: 36),
                  ),
                  const SizedBox(height: 60),
                  AppCard(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: AppTheme.headingStyle,
                          ),
                          const SizedBox(height: 24),
                          AppInputField(
                            hintText: 'Email or Phone',
                            controller: _emailController,
                            prefixIcon: const Icon(
                              Icons.mail_outline,
                              color: AppTheme.textGrey,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email or phone';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          AppInputField(
                            hintText: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: AppTheme.textGrey,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.accentGreen,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          AppButton(
                            text: 'LOGIN',
                            onPressed: _handleLogin,
                            gradient: AppTheme.buttonGradient,
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: Text(
                              'OR',
                              style: AppTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(height: 16),
                          AppButton(
                            text: 'CONTINUE WITH GOOGLE',
                            onPressed: () {},
                            backgroundColor: AppTheme.bgCardLight,
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: AppTheme.bodySmall,
                                children: [
                                  WidgetSpan(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CreateAccountScreen(
                                              onAccountCreated:
                                                  widget.onLoginSuccess,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'CREATE ACCOUNT',
                                        style: AppTheme.bodySmall.copyWith(
                                          color: AppTheme.accentGreen,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                // Continue as guest
                                final gameState =
                                    context.read<GameStateProvider>();
                                gameState.initializePlayer(
                                  'Guest_${DateTime.now().millisecondsSinceEpoch}',
                                  'guest@crazyblock.local',
                                );
                                widget.onLoginSuccess();
                              },
                              child: Text(
                                'Continue as Guest',
                                style: AppTheme.bodySmall.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
