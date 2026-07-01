import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../core/colors.dart';
import '../../core/text_styles.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'widgets/streamer_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCategories(viewModel),
          _buildSubCategories(viewModel),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: viewModel.dummyStreamers.length,
              itemBuilder: (context, index) {
                return StreamerCard(streamer: viewModel.dummyStreamers[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
        child: Image.asset(
          'assets/alive_logo.png',
        ),
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            const Icon(Icons.notifications_none, color: Colors.black87, size: 28),
            Positioned(
              right: -4,
              top: -2,
              child: Container(
                width: 16,
                height: 16,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  '3', 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 10, 
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildCategories(HomeViewModel viewModel) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: viewModel.categories.length,
        itemBuilder: (context, index) {
          final isSelected = viewModel.selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => viewModel.selectCategory(index),
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Center(
                child: Text(
                  viewModel.categories[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColors.primary : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubCategories(HomeViewModel viewModel) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: viewModel.subCategories.length,
        itemBuilder: (context, index) {
          final isSelected = viewModel.selectedSubCategoryIndex == index;
          final category = viewModel.subCategories[index];
          return GestureDetector(
            onTap: () => viewModel.selectSubCategory(index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
                color: isSelected ? Colors.green.shade50 : Colors.transparent,
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.network(
                        category['flag']!,
                        width: 18,
                        height: 12,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag, size: 14),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category['name']!,
                      style: TextStyle(
                        color: isSelected ? AppColors.primary : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFAB() {
    return SizedBox(
      width: 68,
      height: 68,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 3,
        shape: const CircleBorder(),
        child: const Icon(Icons.sensors, color: AppColors.primary, size: 32),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      color: Colors.transparent, // Transparent so the gradient inside shows
      padding: EdgeInsets.zero,
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      clipBehavior: Clip.antiAlias, 
      child: Container(
        height: 65,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFC7EA00), // Yellow-green
              AppColors.primary, // Normal green
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(IconlyBold.home, 'Home', true),
            _buildNavItem(Icons.celebration_outlined, 'Party', false), // Standard icon for party
            const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 28),
                Text(
                  'Go Live',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 6),
              ],
            ),
            _buildNavItem(IconlyLight.send, 'Chats', false),
            _buildNavItem(IconlyLight.profile, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    final color = isSelected ? Colors.white : Colors.white70;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
