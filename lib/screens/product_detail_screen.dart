import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../theme.dart';
import 'payment_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final FoodItem item;
  const ProductDetailScreen({super.key, required this.item});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  double _spicyLevel = 0.4;
  int _portion = 2;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final total = item.price * _portion;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new,
                          size: 18, color: AppColors.dark),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.search, size: 22, color: AppColors.dark),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero image - uses detailImagePath (larger, clearer image)
                    Center(
                      child: SizedBox(
                        height: 280,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Positioned(
                              bottom: 4,
                              child: Container(
                                width: 240,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Image.asset(
                                item.detailImagePath,
                                height: 260,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.fastfood,
                                  size: 120,
                                  color: AppColors.lightGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${item.name} ${item.subtitle}',
                      style: AppTextStyle.roboto(
                        size: 22,
                        weight: FontWeight.w700,
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          item.rating.toString(),
                          style: AppTextStyle.roboto(
                              size: 14, color: AppColors.textGrey),
                        ),
                        const SizedBox(width: 8),
                        Container(
                            width: 6, height: 1, color: AppColors.textGrey),
                        const SizedBox(width: 8),
                        Text(
                          '${item.deliveryMins} mins',
                          style: AppTextStyle.roboto(
                              size: 14, color: AppColors.textGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      item.description,
                      style: AppTextStyle.roboto(
                          size: 14, color: AppColors.grey, height: 1.65),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildSpicySlider()),
                        const SizedBox(width: 24),
                        _buildPortionControl(),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            _buildBottomBar(item, total),
          ],
        ),
      ),
    );
  }

  Widget _buildSpicySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Spicy',
            style: AppTextStyle.roboto(
                size: 14, weight: FontWeight.w600, color: AppColors.dark)),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.lightGrey,
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withOpacity(0.15),
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: _spicyLevel,
            onChanged: (v) => setState(() => _spicyLevel = v),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Mild',
                style: AppTextStyle.roboto(
                    size: 12, weight: FontWeight.w500, color: AppColors.green)),
            Text('Hot',
                style: AppTextStyle.roboto(
                    size: 12,
                    weight: FontWeight.w500,
                    color: AppColors.primary)),
          ],
        ),
      ],
    );
  }

  Widget _buildPortionControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Portion',
            style: AppTextStyle.roboto(
                size: 14, weight: FontWeight.w600, color: AppColors.dark)),
        const SizedBox(height: 12),
        Row(
          children: [
            _portionBtn(Icons.remove, () {
              if (_portion > 1) setState(() => _portion--);
            }, filled: false),
            const SizedBox(width: 14),
            Text('$_portion',
                style: AppTextStyle.inter(
                    size: 18,
                    weight: FontWeight.w600,
                    color: AppColors.dark)),
            const SizedBox(width: 14),
            _portionBtn(Icons.add, () => setState(() => _portion++),
                filled: true),
          ],
        ),
      ],
    );
  }

  Widget _portionBtn(IconData icon, VoidCallback onTap,
      {required bool filled}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.28),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ]
              : null,
        ),
        child: Icon(icon,
            size: 18, color: filled ? Colors.white : AppColors.dark),
      ),
    );
  }

  Widget _buildBottomBar(FoodItem item, double total) {
    return Container(
      padding: const EdgeInsets.fromLTRB(19, 14, 19, 22),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 66,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              '\$${total.toStringAsFixed(2)}',
              style: AppTextStyle.roboto(
                  size: 20, weight: FontWeight.w700, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PaymentScreen(item: item, portion: _portion),
                ),
              ),
              child: Container(
                height: 66,
                decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'ORDER NOW',
                  style: AppTextStyle.inter(
                      size: 17, weight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
