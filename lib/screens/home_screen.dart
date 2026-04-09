import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../theme.dart';
import 'product_detail_screen.dart';
import 'profile_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  int _selectedTab = 0;
  final List<String> _categories = ['All', 'Combos', 'Sliders', 'Classic'];
  final List<FoodItem> _items = List.from(sampleFoodItems);

  void _onTabTapped(int idx) {
    setState(() => _selectedTab = idx);
    if (idx == 1) {
      // Account/profile icon
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
    } else if (idx == 2) {
      // Chat icon
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildHeader(),
                  const SizedBox(height: 26),
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildCategories(),
                  const SizedBox(height: 24),
                  _buildGrid(),
                  const SizedBox(height: 110),
                ],
              ),
            ),
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: _buildBottomNav(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Foodgo',
                  style: AppTextStyle.lobster(size: 42, color: AppColors.dark)),
              Text('Order your favourite food!',
                  style: AppTextStyle.poppins(
                      size: 15, color: AppColors.grey, weight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                AppImages.image8,
                width: 58, height: 58,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const CircleAvatar(
                  radius: 29,
                  backgroundColor: AppColors.lightGrey,
                  child: Icon(Icons.person, color: AppColors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 19,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  const Icon(Icons.search, color: AppColors.dark, size: 22),
                  const SizedBox(width: 12),
                  Text('Search',
                      style: AppTextStyle.roboto(
                          size: 17, color: AppColors.dark, weight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 19),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final selected = i == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(20),
                boxShadow: selected
                    ? [BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 14,
                    offset: const Offset(0, 8))]
                    : null,
              ),
              child: Text(_categories[i],
                  style: AppTextStyle.inter(
                      size: 15,
                      weight: FontWeight.w500,
                      color: selected ? Colors.white : AppColors.grey)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 14,
          childAspectRatio: 0.82,
        ),
        itemCount: _items.length,
        itemBuilder: (context, i) => _buildFoodCard(_items[i]),
      ),
    );
  }

  Widget _buildFoodCard(FoodItem item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailScreen(item: item)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 17,
                offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Image.asset(
                    item.gridImagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.fastfood, size: 56, color: AppColors.lightGrey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: AppTextStyle.roboto(
                          size: 14, weight: FontWeight.w700, color: AppColors.dark)),
                  Text(item.subtitle,
                      style: AppTextStyle.roboto(size: 13, color: AppColors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 15),
                      const SizedBox(width: 3),
                      Text(item.rating.toString(),
                          style: AppTextStyle.roboto(
                              size: 13, weight: FontWeight.w500, color: AppColors.dark)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () =>
                            setState(() => item.isFavorite = !item.isFavorite),
                        child: Icon(
                          item.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: item.isFavorite ? AppColors.primary : AppColors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return SizedBox(
      height: 88,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            size: const Size(double.infinity, 88),
            painter: _BottomNavPainter(),
          ),
          Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navIcon(Icons.home_outlined, 0),
                _navIcon(Icons.person_outline, 1),   // → ProfileScreen
                const SizedBox(width: 72),
                _navIcon(Icons.chat_bubble_outline, 2),  // → ChatScreen
                _navIcon(Icons.favorite_border, 3),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 66, height: 66,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 6)),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _dot(0), _dot(1),
                const SizedBox(width: 72),
                _dot(2), _dot(3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, int idx) {
    return GestureDetector(
      onTap: () => _onTabTapped(idx),
      child: Icon(icon,
          color: _selectedTab == idx ? AppColors.primary : AppColors.grey,
          size: 24),
    );
  }

  Widget _dot(int idx) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _selectedTab == idx ? 1.0 : 0.0,
      child: Container(
        width: 4, height: 4,
        decoration: const BoxDecoration(
            color: AppColors.primary, shape: BoxShape.circle),
      ),
    );
  }
}

class _BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.07)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    final path = _buildPath(size);
    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
  }

  Path _buildPath(Size size) {
    final w = size.width;
    const r = 40.0;
    const cx = 0.5;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(w * cx - r - 18, 0);
    path.quadraticBezierTo(w * cx - r, 0, w * cx - r, r * 0.55);
    path.arcToPoint(
      Offset(w * cx + r, r * 0.55),
      radius: const Radius.circular(r),
      clockwise: false,
    );
    path.quadraticBezierTo(w * cx + r, 0, w * cx + r + 18, 0);
    path.lineTo(w, 0);
    path.lineTo(w, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
