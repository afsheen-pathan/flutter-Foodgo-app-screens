import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../theme.dart';
import 'customize_screen.dart';

class PaymentScreen extends StatefulWidget {
  final FoodItem item;
  final int portion;
  const PaymentScreen({super.key, required this.item, required this.portion});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPayment = 0;
  bool _saveCard = true;

  double get _orderTotal => widget.item.price * widget.portion;
  double get _tax => double.parse((_orderTotal * 0.018).toStringAsFixed(2));
  double get _delivery => 1.5;
  double get _total => _orderTotal + _tax + _delivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
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
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text('Order summary',
                        style: AppTextStyle.poppins(
                            size: 20, weight: FontWeight.w700, color: AppColors.dark)),
                    const SizedBox(height: 24),
                    _summaryRow('Order', '\$${_orderTotal.toStringAsFixed(2)}'),
                    const SizedBox(height: 16),
                    _summaryRow('Taxes', '\$${_tax.toStringAsFixed(2)}'),
                    const SizedBox(height: 16),
                    _summaryRow('Delivery fees', '\$${_delivery.toStringAsFixed(1)}'),
                    const SizedBox(height: 14),
                    const Divider(color: Color(0xFFE0E0E0)),
                    const SizedBox(height: 14),
                    _summaryRow('Total:', '\$${_total.toStringAsFixed(2)}', bold: true),
                    const SizedBox(height: 6),
                    _summaryRow('Estimated delivery time:', '15 - 30mins', small: true),
                    const SizedBox(height: 26),
                    Text('Payment methods',
                        style: AppTextStyle.poppins(
                            size: 20, weight: FontWeight.w700, color: AppColors.dark)),
                    const SizedBox(height: 14),
                    _paymentCard(
                      index: 0,
                      cardType: 'Credit card',
                      cardNumber: '5105 **** **** 0505',
                      logoAsset: AppImages.image141,
                    ),
                    const SizedBox(height: 12),
                    _paymentCard(
                      index: 1,
                      cardType: 'Debit card',
                      cardNumber: '3566 **** **** 0505',
                      logoAsset: AppImages.image13,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _saveCard = !_saveCard),
                          child: Container(
                            width: 18, height: 18,
                            decoration: BoxDecoration(
                              color: _saveCard ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: _saveCard ? AppColors.primary : AppColors.grey,
                              ),
                            ),
                            child: _saveCard
                                ? const Icon(Icons.check, size: 12, color: Colors.white)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('Save card details for future payments',
                            style: AppTextStyle.roboto(size: 13, color: AppColors.textGrey)),
                      ],
                    ),
                    const SizedBox(height: 80),
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

  Widget _summaryRow(String label, String value, {bool bold = false, bool small = false}) {
    final style = AppTextStyle.roboto(
      size: small ? 13 : 17,
      weight: bold ? FontWeight.w700 : FontWeight.w400,
      color: bold ? AppColors.dark : AppColors.textGrey,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: style)],
    );
  }

  Widget _paymentCard({
    required int index,
    required String cardType,
    required String cardNumber,
    required String logoAsset,
  }) {
    final selected = _selectedPayment == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 80,
        decoration: BoxDecoration(
          color: selected ? AppColors.dark : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(20),
          boxShadow: selected
              ? [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  logoAsset,
                  width: 70, height: 44,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.credit_card, size: 36, color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cardType,
                        style: AppTextStyle.roboto(
                            size: 14,
                            weight: FontWeight.w600,
                            color: selected ? Colors.white : AppColors.dark)),
                    Text(cardNumber,
                        style: AppTextStyle.roboto(size: 13, color: AppColors.textGrey)),
                  ],
                ),
              ),
              Container(
                width: 20, height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: selected ? Colors.white : AppColors.grey, width: 2),
                ),
                child: selected
                    ? Center(
                  child: Container(
                    width: 9, height: 9,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(19, 14, 19, 22),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -3)),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total price',
                  style: AppTextStyle.roboto(size: 14, color: AppColors.textGrey)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '\$',
                        style: AppTextStyle.roboto(
                            size: 30, weight: FontWeight.w700, color: AppColors.primary)),
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
              // Pay Now → goes to Customize/Toppings screen
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomizeScreen(
                    item: widget.item,
                    portion: widget.portion,
                  ),
                ),
              ),
              child: Container(
                height: 66,
                decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text('Pay Now',
                    style: AppTextStyle.roboto(
                        size: 18, weight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
