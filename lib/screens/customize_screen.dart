import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../theme.dart';
import 'success_screen.dart';

class CustomizeScreen extends StatefulWidget {
  final FoodItem item;
  final int portion;
  const CustomizeScreen({super.key, required this.item, required this.portion});

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  double _spicyLevel = 0.7;
  late int _portion;

  @override
  void initState() {
    super.initState();
    _portion = widget.portion;
  }

  final List<Map<String, dynamic>> _toppings = [
    {'name': 'Tomato',   'image': 'assets/images/pngwing15.png',  'selected': false},
    {'name': 'Onions',   'image': 'assets/images/pngwing16.png',  'selected': false},
    {'name': 'Pickles',  'image': 'assets/images/pngwing17.png',  'selected': false},
    {'name': 'Bacons',   'image': 'assets/images/pngwing18.png',  'selected': false},
    {'name': 'Cheese',   'image': 'assets/images/pngwing19.png',  'selected': false},
    {'name': 'Mushroom', 'image': 'assets/images/pngwing20.png',  'selected': false},
    {'name': 'Avocado',  'image': 'assets/images/pngwing21.png',  'selected': false},
  ];

  final List<Map<String, dynamic>> _sides = [
    {'name': 'Fries',    'image': 'assets/images/image14.png',      'selected': true},
    {'name': 'Coleslaw', 'image': 'assets/images/image15.png',      'selected': false},
    {'name': 'Salad',    'image': 'assets/images/pngwing12_1.png',  'selected': false},
    {'name': 'Onion',    'image': 'assets/images/pngwing14.png',    'selected': false},
    {'name': 'Mozz.',    'image': 'assets/images/pngwing23.png',    'selected': false},
  ];

  double get _extrasTotal {
    int count = _toppings.where((t) => t['selected'] == true).length +
        _sides.where((s) => s['selected'] == true).length;
    return count * 0.5;
  }

  double get _total => widget.item.price * _portion + _extrasTotal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroSection(),
                    const SizedBox(height: 8),
                    _buildSectionTitle('Toppings'),
                    const SizedBox(height: 12),
                    _buildItemRow(_toppings),
                    const SizedBox(height: 18),
                    _buildSectionTitle('Side options'),
                    const SizedBox(height: 12),
                    _buildItemRow(_sides),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.dark),
            ),
          ),
          const Spacer(),
          const Icon(Icons.search, size: 22, color: AppColors.dark),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exploded burger image (pngwing12)
          Expanded(
            flex: 5,
            child: Image.asset(
              'assets/images/pngwing12.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Image.asset(
                widget.item.detailImagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                    Icons.fastfood, size: 80, color: AppColors.lightGrey),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Controls panel
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Customize ',
                          style: AppTextStyle.roboto(
                              size: 14, weight: FontWeight.w800, color: AppColors.dark),
                        ),
                        TextSpan(
                          text: 'Your Burger to Your Tastes. Ultimate Experience',
                          style: AppTextStyle.roboto(size: 12, color: AppColors.grey, height: 1.55),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Spicy
                  Text('Spicy',
                      style: AppTextStyle.roboto(
                          size: 13, weight: FontWeight.w500, color: AppColors.dark)),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: AppColors.lightGrey,
                      thumbColor: AppColors.primary,
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                    ),
                    child: Slider(
                      value: _spicyLevel,
                      onChanged: (v) => setState(() => _spicyLevel = v),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mild', style: AppTextStyle.roboto(
                          size: 10, weight: FontWeight.w500, color: AppColors.green)),
                      Text('Hot', style: AppTextStyle.roboto(
                          size: 10, weight: FontWeight.w500, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Portion
                  Text('Portion',
                      style: AppTextStyle.roboto(
                          size: 13, weight: FontWeight.w500, color: AppColors.dark)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _portionBtn(Icons.remove,
                              () { if (_portion > 1) setState(() => _portion--); },
                          filled: false),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('$_portion',
                            style: AppTextStyle.inter(
                                size: 18, weight: FontWeight.w600, color: AppColors.dark)),
                      ),
                      _portionBtn(Icons.add,
                              () => setState(() => _portion++),
                          filled: true),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: AppTextStyle.roboto(size: 18, weight: FontWeight.w700, color: AppColors.dark));
  }

  Widget _buildItemRow(List<Map<String, dynamic>> list) {
    return SizedBox(
      height: 116,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _ingredientCard(list, i),
      ),
    );
  }

  Widget _ingredientCard(List<Map<String, dynamic>> list, int index) {
    final item = list[index];
    final selected = item['selected'] as bool;
    return GestureDetector(
      onTap: () => setState(() => list[index]['selected'] = !selected),
      child: SizedBox(
        width: 84,
        height: 116,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Dark bottom card
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                height: 69,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.dark,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 18, offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),
            ),
            // White top card
            Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                height: 78,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 10),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    item['image'] as String,
                    width: 54, height: 50,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.restaurant,
                      size: 30,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ),
            ),
            // Label + button at bottom
            Positioned(
              bottom: 6, left: 6, right: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      item['name'] as String,
                      style: AppTextStyle.roboto(
                          size: 10, weight: FontWeight.w500, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 16, height: 16,
                    decoration: BoxDecoration(
                      color: selected ? Colors.white : AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      selected ? Icons.check : Icons.add,
                      size: 10,
                      color: selected ? AppColors.primary : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _portionBtn(IconData icon, VoidCallback onTap, {required bool filled}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: filled
              ? [BoxShadow(
              color: Colors.orange.withOpacity(0.28),
              blurRadius: 12,
              offset: const Offset(0, 6))]
              : null,
        ),
        child: Icon(icon, size: 16, color: filled ? Colors.white : AppColors.dark),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(19, 14, 19, 22),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, -3)),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total',
                  style: AppTextStyle.roboto(
                      size: 15, weight: FontWeight.w600, color: AppColors.dark)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '\$',
                        style: AppTextStyle.roboto(
                            size: 22, weight: FontWeight.w700, color: AppColors.primary)),
                    TextSpan(text: _total.toStringAsFixed(2),
                        style: AppTextStyle.roboto(
                            size: 30, weight: FontWeight.w700, color: AppColors.dark)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SuccessScreen()),
              ),
              child: Container(
                height: 66,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 7)),
                  ],
                ),
                alignment: Alignment.center,
                child: Text('ORDER NOW',
                    style: AppTextStyle.inter(
                        size: 17, weight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
