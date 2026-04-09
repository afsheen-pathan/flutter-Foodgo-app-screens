import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Red header with avatar
            _buildRedHeader(),
            // Form body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _inputField('Name', 'Sophia Patel', Icons.person_outline),
                    const SizedBox(height: 14),
                    _inputField('Email', 'sophiapatel@gmail.com', Icons.email_outlined),
                    const SizedBox(height: 14),
                    _inputField('Delivery address',
                        '123 Main St Apartment 4A, New York, NY', Icons.location_on_outlined),
                    const SizedBox(height: 14),
                    _passwordField(),
                    const SizedBox(height: 28),
                    _menuRow('Payment Details'),
                    const Divider(color: Color(0xFFEEEEEE), height: 1),
                    _menuRow('Order history'),
                    const SizedBox(height: 36),
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.dark,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Edit Profile',
                                    style: AppTextStyle.roboto(
                                        size: 15,
                                        weight: FontWeight.w600,
                                        color: Colors.white)),
                                const SizedBox(width: 8),
                                const Icon(Icons.edit_outlined,
                                    color: Colors.white, size: 18),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 56,
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: AppColors.primary, width: 2),
                            ),
                            child: Row(
                              children: [
                                Text('Log out',
                                    style: AppTextStyle.roboto(
                                        size: 15,
                                        weight: FontWeight.w600,
                                        color: AppColors.primary)),
                                const SizedBox(width: 8),
                                const Icon(Icons.logout,
                                    color: AppColors.primary, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRedHeader() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF6B7A), Color(0xFFEF2A39)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -30, right: -30,
            child: Container(
              width: 140, height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -20, left: 40,
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          // Top bar with back + settings
          Positioned(
            top: 12, left: 12, right: 12,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 16, color: Colors.white),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.settings_outlined,
                      size: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          // Avatar centered
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Container(
                  width: 84, height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/image8.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.white.withOpacity(0.3),
                        child: const Icon(Icons.person,
                            size: 40, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyle.roboto(
                size: 12, weight: FontWeight.w500, color: AppColors.textGrey)),
        const SizedBox(height: 6),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8E8E8)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(value,
                      style: AppTextStyle.roboto(
                          size: 14, color: AppColors.dark)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password',
            style: AppTextStyle.roboto(
                size: 12, weight: FontWeight.w500, color: AppColors.textGrey)),
        const SizedBox(height: 6),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8E8E8)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _showPassword ? 'mypassword123' : '••••••••••',
                    style: AppTextStyle.roboto(
                        size: _showPassword ? 14 : 18,
                        color: AppColors.dark,
                        weight: FontWeight.w400),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _showPassword = !_showPassword),
                  child: Icon(
                    _showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuRow(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Text(title,
              style: AppTextStyle.roboto(
                  size: 15, color: AppColors.dark, weight: FontWeight.w500)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: AppColors.grey, size: 22),
        ],
      ),
    );
  }
}
