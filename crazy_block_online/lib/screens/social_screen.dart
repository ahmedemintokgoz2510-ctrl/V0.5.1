import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../models/friend.dart';
import '../providers/game_state.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  int _selectedTab = 0;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildTabBar(),
              const SizedBox(height: 16),
              Expanded(
                child: _buildTabContent(),
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
            'SOCIAL',
            style: AppTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ['MY FRIENDS', 'FIND FRIENDS', 'INVITATIONS'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == index
                      ? AppTheme.bgCardLight
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedTab == index
                        ? AppTheme.accentGreen
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      tabs[index],
                      style: AppTheme.labelMedium.copyWith(
                        fontSize: 11,
                        color: _selectedTab == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (index == 2)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.buttonRed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Consumer<GameStateProvider>(
                          builder: (context, gameState, child) {
                            return Text(
                              gameState.friendRequests.length.toString(),
                              style: AppTheme.bodySmall.copyWith(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildMyFriendsTab();
      case 1:
        return _buildFindFriendsTab();
      case 2:
        return _buildInvitationsTab();
      default:
        return const SizedBox();
    }
  }

  Widget _buildMyFriendsTab() {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                if (gameState.friends.isEmpty)
                  AppCard(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 48,
                          color: AppTheme.accentGreen.withOpacity(0.6),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No Friends Yet',
                          style: AppTheme.headingStyle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Go to Find Friends to add someone!',
                          style: AppTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                else
                  ...gameState.friends.map((friend) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildFriendCard(friend, context),
                    );
                  }).toList(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFriendCard(Friend friend, BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.blockOrange, AppTheme.blockRed],
              ),
            ),
            child: Center(
              child: Text(
                friend.name.substring(0, 1).toUpperCase(),
                style: AppTheme.labelLarge,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.name,
                  style: AppTheme.bodyLarge,
                ),
                Text(
                  'ID: ${friend.id}',
                  style: AppTheme.bodySmall,
                ),
                Text(
                  friend.status == FriendStatus.online
                      ? '🟢 online'
                      : '🔘 offline',
                  style: AppTheme.bodySmall.copyWith(
                    color: friend.status == FriendStatus.online
                        ? AppTheme.buttonGreen
                        : AppTheme.textGrey,
                  ),
                ),
              ],
            ),
          ),
          AppButton(
            text: 'INVITE',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invited ${friend.name} to play!'),
                ),
              );
            },
            width: 80,
            height: 40,
            textStyle: AppTheme.labelMedium.copyWith(fontSize: 10),
            gradient: AppTheme.buttonGradient,
          ),
        ],
      ),
    );
  }

  Widget _buildFindFriendsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppTheme.bgCardLight,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Icon(
                      Icons.search,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: AppTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Enter Player ID or Name',
                        hintStyle: AppTheme.bodySmall,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AppButton(
                      text: 'SEARCH',
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Searched for: ${_searchController.text}',
                              ),
                            ),
                          );
                        }
                      },
                      width: 80,
                      height: 40,
                      textStyle: AppTheme.labelMedium.copyWith(fontSize: 10),
                      gradient: AppTheme.buttonGradient,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 48,
                    color: AppTheme.accentGreen.withOpacity(0.6),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Search for Players',
                    style: AppTheme.headingStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Search by player ID or name to find and add friends!',
                    style: AppTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInvitationsTab() {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                if (gameState.friendRequests.isEmpty)
                  AppCard(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.mail_outline,
                          size: 48,
                          color: AppTheme.accentGreen.withOpacity(0.6),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No Invitations',
                          style: AppTheme.headingStyle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You have no pending friend requests',
                          style: AppTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                else
                  ...gameState.friendRequests.map((request) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppTheme.blockGreen,
                                    Colors.green,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  request.name
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: AppTheme.labelLarge,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    request.name,
                                    style: AppTheme.bodyLarge,
                                  ),
                                  Text(
                                    'ID: ${request.id}',
                                    style: AppTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            AppButton(
                              text: '✓',
                              onPressed: () {
                                gameState.addFriend(request);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Added ${request.name} as friend!',
                                    ),
                                  ),
                                );
                              },
                              width: 40,
                              height: 40,
                              textStyle: AppTheme.labelLarge,
                              gradient: AppTheme.buttonGradient,
                            ),
                            const SizedBox(width: 8),
                            AppButton(
                              text: '✕',
                              onPressed: () {
                                gameState.removeFriendRequest(request.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Friend request declined'),
                                  ),
                                );
                              },
                              width: 40,
                              height: 40,
                              textStyle: AppTheme.labelLarge,
                              backgroundColor: AppTheme.buttonRed,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
