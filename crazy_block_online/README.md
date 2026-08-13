# Crazy Block Online - V0.5

A colorful, polished Block Blast-inspired puzzle game built with Flutter.

## Project Overview

**Crazy Block Online V0.5** is a functional UI foundation for a mobile block puzzle game. This version focuses on:

- ✅ Complete app structure and navigation
- ✅ Authentication/account system (local session-based)
- ✅ Main menu with all primary screens
- ✅ Game board placeholder (ready for Flame integration)
- ✅ Market structure (empty state for V1)
- ✅ Social system (friends, find friends, invitations)
- ✅ Settings with functional toggles
- ✅ Account information display
- ✅ Language selection
- ✅ About/Info screens
- ✅ Beautiful visual design
- ✅ Smooth animations and transitions

## Technology Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Target**: Android/iOS mobile platforms

## Project Structure

```
crazy_block_online/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/
│   │   ├── player.dart          # Player model
│   │   └── friend.dart          # Friend model
│   ├── providers/
│   │   └── game_state.dart      # Global state management
│   ├── screens/
│   │   ├── loading_screen.dart
│   │   ├── login_screen.dart
│   │   ├── create_account_screen.dart
│   │   ├── main_menu_screen.dart
│   │   ├── game_screen.dart
│   │   ├── market_screen.dart
│   │   ├── social_screen.dart
│   │   ├── settings_screen.dart
│   │   ├── account_screen.dart
│   │   ├── language_screen.dart
│   │   └── about_screen.dart
│   ├── theme/
│   │   └── app_theme.dart       # Colors, gradients, text styles
│   └── widgets/
│       ├── app_button.dart
│       └── app_card.dart
├── pubspec.yaml                  # Dependencies
└── README.md
```

## Key Features

### Authentication
- Login screen with email/phone support
- Account creation flow
- Guest login option
- Session-based player management

### Main Menu
- Play/Classic Game button
- Mini Games (placeholder for V1)
- Market, Social, Settings navigation
- Player info display with coins

### Game Screen
- 8x8 game board grid
- Score tracking (starts at 0)
- Pause/resume controls
- Next pieces preview
- Game restart functionality

### Market
- Empty state design
- Tab structure (Blocks, Backgrounds, GIFs)
- Placeholder for future cosmetics
- Coins display

### Social System
- **My Friends**: List of added friends with online/offline status
- **Find Friends**: Search functionality for discovering players
- **Invitations**: Accept/decline friend requests with badge counter

### Settings
- Music toggle (functional)
- Sound Effects toggle (functional)
- Notifications toggle (functional)
- Quick navigation to Account, Language, and About

### Account
- Display player name and ID
- Account details view
- Security section (password, 2FA, login history)
- Danger zone (account deletion)

### Language Selection
- 12 languages available
- Immediate language change
- Visual feedback with checkmarks

### About Screen
- App version and branding
- Game features list
- Legal links (Terms, Privacy, Support)
- Credits and social links

## Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio or Xcode (for device testing)

### Installation

1. **Extract the project**
   ```bash
   unzip crazy_block_online.zip
   cd crazy_block_online
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

For Android:
```bash
flutter run -d android
```

For iOS:
```bash
flutter run -d ios
```

## Important Notes for V0.5

### Not Yet Implemented (Planned for V1+)
- Actual Block Blast gameplay logic
- Flame game engine integration
- Online multiplayer matches
- Real backend authentication (Firebase)
- Real-time leaderboards
- In-app purchases and real coin economy
- Audio playback (SFX/Music) - toggles work, no actual audio files
- Notifications system
- Cloud save/sync

### Current Limitations
- Game board is a placeholder grid
- No actual block placement/clearing mechanics
- No real-time online features
- Player data stored locally (session-based)
- Market items are empty (for future implementation)
- No actual purchase transactions

## Architecture for Future Development

### For Flame Integration (V1)
The `GameScreen` is structured to easily integrate Flame:

1. Replace the placeholder grid with a Flame `GameWidget`
2. Create game logic classes for:
   - Block management
   - Grid state
   - Collision detection
   - Line clearing
   - Scoring system

3. Use existing `GameStateProvider` for score/coins synchronization

### For Backend Integration
The `GameStateProvider` is designed to be replaced with actual backend calls:
- Replace mock friend lists with Firebase queries
- Replace local player storage with Firebase Auth
- Add Firestore for persistent player data
- Implement Cloud Functions for game logic

## Customization

### Colors & Theme
Edit `/lib/theme/app_theme.dart` to customize:
- Primary colors
- Block colors
- Gradients
- Text styles
- Shadows and effects

### Screens
Each screen is modular and can be:
- Modified independently
- Themed separately
- Connected to different navigation flows

### State Management
All app state flows through `GameStateProvider`:
```dart
// Access state
final gameState = context.read<GameStateProvider>();

// Listen to changes
Consumer<GameStateProvider>(
  builder: (context, gameState, child) { ... }
)

// Modify state
gameState.addScore(100);
gameState.toggleMusic();
gameState.addFriend(friend);
```

## Testing Checklist

- [x] Loading screen animation works
- [x] Login/account creation screens functional
- [x] All navigation works correctly
- [x] Settings toggles change state
- [x] Player ID and name display correctly
- [x] Score starts at 0 (no hardcoded data)
- [x] Social tabs display properly
- [x] Market shows empty state
- [x] Language selection works
- [x] All buttons have proper animations
- [x] No reference image data is hardcoded
- [x] UI uses real Flutter widgets (no screenshots)

## Next Steps (V1 Development)

1. **Integrate Flame Game Engine**
   - Build game board with Flame components
   - Implement block physics
   - Add particle effects

2. **Implement Gameplay**
   - Block placement logic
   - Line clearing algorithm
   - Scoring system with combos

3. **Backend Connection**
   - Firebase authentication
   - Firestore for player data
   - Cloud Functions for validation

4. **Audio System**
   - Implement actual SFX playback
   - Background music
   - Respect audio toggles from settings

5. **Multiplayer**
   - Real-time game invitations
   - Live match mechanics
   - Leaderboard system

## File Size & Performance

- Minimal dependencies (provider, shared_preferences)
- No unnecessary assets
- Optimized animations
- ~15-20MB final APK (without Flame)

## Support

This is a V0.5 foundation project. For questions about:
- Flame integration: Check [Flame documentation](https://flame-engine.org/)
- Firebase setup: See [Firebase for Flutter](https://firebase.flutter.dev/)
- Flutter best practices: Visit [Flutter docs](https://flutter.dev/docs)

## License

© 2026 Crazy Block Online. Made by Zodiac.

---

**Version**: 0.5.0  
**Last Updated**: 2026  
**Status**: Foundation Complete - Ready for Gameplay Development
