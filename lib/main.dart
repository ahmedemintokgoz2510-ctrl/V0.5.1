import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_state.dart';
import 'screens/loading_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_menu_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameStateProvider(),
      child: const CrazyBlockOnlineApp(),
    ),
  );
}

class CrazyBlockOnlineApp extends StatelessWidget {
  const CrazyBlockOnlineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crazy Block Online',
      theme: ThemeData(
        primaryColor: AppTheme.primaryBlue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: const AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  void _startApp() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleLoginSuccess() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingScreen(
        onLoadingComplete: () {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }

    if (!_isLoggedIn) {
      return LoginScreen(
        onLoginSuccess: _handleLoginSuccess,
      );
    }

    return MainMenuScreen(
      onLogout: _handleLogout,
    );
  }
}
