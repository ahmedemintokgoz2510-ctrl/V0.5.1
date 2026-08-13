import 'package:flutter/material.dart';
import 'dart:math';
import '../models/player.dart';
import '../models/friend.dart';

class GameStateProvider extends ChangeNotifier {
  Player? _currentPlayer;
  List<Friend> _friends = [];
  List<Friend> _friendRequests = [];
  int _currentScore = 0;
  int _currentCoins = 0;
  bool _isMusicOn = true;
  bool _isSfxOn = true;
  bool _notificationsOn = true;
  String _selectedLanguage = 'English';
  String _selectedBackground = 'Classic Blue';
  String _selectedBlockStyle = 'Classic Blocks';
  String _selectedGif = '';

  // Getters
  Player? get currentPlayer => _currentPlayer;
  List<Friend> get friends => _friends;
  List<Friend> get friendRequests => _friendRequests;
  int get currentScore => _currentScore;
  int get currentCoins => _currentCoins;
  bool get isMusicOn => _isMusicOn;
  bool get isSfxOn => _isSfxOn;
  bool get notificationsOn => _notificationsOn;
  String get selectedLanguage => _selectedLanguage;
  String get selectedBackground => _selectedBackground;
  String get selectedBlockStyle => _selectedBlockStyle;
  String get selectedGif => _selectedGif;

  // Initialize with a player
  void initializePlayer(String name, String email) {
    final playerId = _generatePlayerId();
    _currentPlayer = Player(
      id: playerId,
      name: name,
      email: email,
      coins: _currentCoins,
      highScore: 0,
    );
    _initializeMockFriends();
    _initializeMockRequests();
    notifyListeners();
  }

  // Generate unique player ID
  String _generatePlayerId() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8);
  }

  // Mock friends data
  void _initializeMockFriends() {
    _friends = [
      Friend(id: '001', name: 'PuzzlePro', status: FriendStatus.online, highScore: 5200),
      Friend(id: '002', name: 'CubeMaster', status: FriendStatus.online, highScore: 4800),
      Friend(id: '003', name: 'GridGirl', status: FriendStatus.online, highScore: 5600),
      Friend(id: '004', name: 'BrickBeast', status: FriendStatus.offline, highScore: 3200),
      Friend(id: '005', name: 'BlockHeads', status: FriendStatus.offline, highScore: 2900),
      Friend(id: '006', name: 'PlayerHom', status: FriendStatus.online, highScore: 4400),
      Friend(id: '007', name: 'PlayerGucl', status: FriendStatus.online, highScore: 5100),
      Friend(id: '008', name: 'PlayerSen', status: FriendStatus.offline, highScore: 3800),
    ];
  }

  // Mock friend requests
  void _initializeMockRequests() {
    _friendRequests = [
      Friend(id: '101', name: 'PuzzleMaster78', status: FriendStatus.online),
      Friend(id: '102', name: 'BrickPlayer', status: FriendStatus.online),
      Friend(id: '103', name: 'CubeCruiser', status: FriendStatus.online),
    ];
  }

  // Game Methods
  void resetGameScore() {
    _currentScore = 0;
    notifyListeners();
  }

  void addScore(int points) {
    _currentScore += points;
    if (_currentScore > (_currentPlayer?.highScore ?? 0)) {
      _currentPlayer = _currentPlayer?.copyWith(highScore: _currentScore);
    }
    notifyListeners();
  }

  void addCoins(int amount) {
    _currentCoins += amount;
    _currentPlayer = _currentPlayer?.copyWith(coins: _currentCoins);
    notifyListeners();
  }

  bool spendCoins(int amount) {
    if (_currentCoins >= amount) {
      _currentCoins -= amount;
      _currentPlayer = _currentPlayer?.copyWith(coins: _currentCoins);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Settings Methods
  void toggleMusic() {
    _isMusicOn = !_isMusicOn;
    notifyListeners();
  }

  void toggleSfx() {
    _isSfxOn = !_isSfxOn;
    notifyListeners();
  }

  void toggleNotifications() {
    _notificationsOn = !_notificationsOn;
    notifyListeners();
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void setBackground(String background) {
    _selectedBackground = background;
    notifyListeners();
  }

  void setBlockStyle(String blockStyle) {
    _selectedBlockStyle = blockStyle;
    notifyListeners();
  }

  void setGif(String gif) {
    _selectedGif = gif;
    notifyListeners();
  }

  // Social Methods
  void addFriend(Friend friend) {
    if (!_friends.any((f) => f.id == friend.id)) {
      _friends.add(friend);
      _friendRequests.removeWhere((f) => f.id == friend.id);
      notifyListeners();
    }
  }

  void removeFriendRequest(String friendId) {
    _friendRequests.removeWhere((f) => f.id == friendId);
    notifyListeners();
  }

  void searchAndAddFriend(String searchQuery) {
    // Mock search - in real app this would query backend
    final mockSearchResults = [
      Friend(id: 'sr_001', name: 'SearchResult_$searchQuery', status: FriendStatus.online),
    ];
    // Add to requests would happen here
  }

  void logout() {
    _currentPlayer = null;
    _friends = [];
    _friendRequests = [];
    _currentScore = 0;
    _currentCoins = 0;
    notifyListeners();
  }
}
