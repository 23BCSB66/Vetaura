import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/donation_amount_card.dart';
import '../widgets/impact_card.dart';
import '../widgets/cause_chip.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  String selectedAmount = '₹250';
  String selectedCause = 'Food';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Donate',
          style: TextStyle(color: AppColors.textDark),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// =======================
// 🐶 HERO CONTAINER
// =======================
            Container(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: AssetImage('assets/images/hero_pet.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.55),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'A small help\ncan save a life 🐾',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // =======================
            // 💰 DONATION AMOUNT
            // =======================
            const Text(
              'Choose amount',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AmountCard(
                  amount: '₹100',
                  isSelected: selectedAmount == '₹100',
                  onTap: () => setState(() => selectedAmount = '₹100'),
                ),
                AmountCard(
                  amount: '₹250',
                  isSelected: selectedAmount == '₹250',
                  onTap: () => setState(() => selectedAmount = '₹250'),
                ),
                AmountCard(
                  amount: '₹500',
                  isSelected: selectedAmount == '₹500',
                  onTap: () => setState(() => selectedAmount = '₹500'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // =======================
            // 🌱 IMPACT SECTION
            // =======================
            const Text(
              'Your impact',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ImpactCard(
                  icon: Icons.restaurant,
                  title: 'Meals',
                  subtitle: 'Feeds a stray',
                ),
                ImpactCard(
                  icon: Icons.medical_services,
                  title: 'Treatment',
                  subtitle: 'Basic care',
                ),
                ImpactCard(
                  icon: Icons.home,
                  title: 'Shelter',
                  subtitle: 'Safe place',
                ),
              ],
            ),

            const SizedBox(height: 32),

            // =======================
            // 🏷️ CAUSE SELECTION
            // =======================
            const Text(
              'Choose cause',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              children: [
                CauseChip(
                  label: 'Food',
                  isSelected: selectedCause == 'Food',
                  onTap: () => setState(() => selectedCause = 'Food'),
                ),
                CauseChip(
                  label: 'Treatment',
                  isSelected: selectedCause == 'Treatment',
                  onTap: () => setState(() => selectedCause = 'Treatment'),
                ),
                CauseChip(
                  label: 'Shelter',
                  isSelected: selectedCause == 'Shelter',
                  onTap: () => setState(() => selectedCause = 'Shelter'),
                ),
              ],
            ),

            const SizedBox(height: 36),

            // =======================
            // ❤️ DONATE BUTTON
            // =======================
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 6,
                  shadowColor: AppColors.primary.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Donate Now ❤️',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
