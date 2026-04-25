import 'package:flutter/material.dart';
import 'booking_checkout_screen.dart';
import 'vet_chat_screen.dart';

class PremiumServicesScreen extends StatefulWidget {
  const PremiumServicesScreen({super.key});

  @override
  State<PremiumServicesScreen> createState() => _PremiumServicesScreenState();
}

class _PremiumServicesScreenState extends State<PremiumServicesScreen> {
  bool atHome = true;

  Color _surfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF17231F)
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 42),
                    Expanded(
                      child: Text(
                        'Services',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: onSurface,
                        ),
                      ),
                    ),
                    const Icon(Icons.notifications_none_rounded),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Premium care tailored for your companion's wellness.",
                  style: TextStyle(fontSize: 16, height: 1.45),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF22322D) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    children: [
                      _toggle('At Home', atHome, () => setState(() => atHome = true)),
                      _toggle('Visit Clinic', !atHome, () => setState(() => atHome = false)),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                _sectionHeader('Featured Experts', 'SEE ALL'),
                const SizedBox(height: 14),
                _expertCard(
                  title: 'Vet Visit',
                  subtitle: 'Emergency consultations and routine health checkups at your doorstep.',
                  price: 'Rs 699/session',
                  rating: '4.9',
                  distance: '0.8 miles away',
                  icon: Icons.medical_services_rounded,
                  color: Colors.green,
                  button: 'Book Now',
                ),
                const SizedBox(height: 16),
                _expertCard(
                  title: 'Grooming',
                  subtitle: 'Full spa treatment including bathing, styling, and nail trim.',
                  price: 'Rs 799/pet',
                  rating: '4.7',
                  distance: '1.4 miles away',
                  icon: Icons.content_cut_rounded,
                  color: Colors.pink,
                  button: 'Details',
                ),
                const SizedBox(height: 30),
                const Text(
                  'Daily Care',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 14),
                _dailyCare('Walking', '30, 60 or 90 min active strolls', 'Rs 299', Icons.directions_walk_rounded, Colors.green),
                _dailyCare('Training', 'Behavioral and skill development', 'Rs 899', Icons.psychology_rounded, Colors.orange),
                _dailyCare('Bathing Session', 'Warm bath and gentle brushing', 'Rs 349', Icons.water_drop_rounded, Colors.blue),
                _dailyCare('Deworming Session', 'Vet-guided parasite prevention', 'Rs 299', Icons.medication_liquid_rounded, Colors.deepOrange),
                _dailyCare('Hair Trimming Session', 'Trim, paw cleanup and styling', 'Rs 399', Icons.content_cut_rounded, Colors.pink),
                const SizedBox(height: 24),
                _emergencyCard(context),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 120),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _toggle(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: selected ? _surfaceColor(context) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        Text(action, style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.green.shade400 : Colors.green.shade800, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _expertCard({
    required String title,
    required String subtitle,
    required String price,
    required String rating,
    required String distance,
    required IconData icon,
    required MaterialColor color,
    required String button,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double ratingVal = double.tryParse(rating) ?? 0.0;
    Color ratingColor;
    if (ratingVal >= 4.0) {
      ratingColor = Colors.green;
    } else if (ratingVal >= 3.0) {
      ratingColor = Colors.orange;
    } else {
      ratingColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _surfaceColor(context),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: isDark ? color.withOpacity(0.15) : color.shade50,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Icon(icon, color: isDark ? color.shade400 : color.shade500, size: 34),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black26 : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: TextStyle(
                            color: ratingColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(distance, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(subtitle, style: const TextStyle(height: 1.45)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: isDark ? Colors.green.shade400 : Colors.green.shade800)),
              const Spacer(),
              FilledButton(
                onPressed: () => _book(title, price),
                style: FilledButton.styleFrom(
                  backgroundColor: button == 'Book Now' ? Colors.green.shade800 : (isDark ? Colors.white12 : Colors.grey.shade100),
                  foregroundColor: button == 'Book Now' ? Colors.white : (isDark ? Colors.white : Colors.black87),
                ),
                child: Text(button),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dailyCare(String title, String subtitle, String price, IconData icon, MaterialColor color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceColor(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: () => _book(title, price),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isDark ? color.withOpacity(0.15) : color.shade100.withOpacity(0.65),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: isDark ? color.shade400 : color.shade700),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: const TextStyle(fontSize: 12, height: 1.25)),
                ],
              ),
            ),
            Text(price, style: TextStyle(fontWeight: FontWeight.w900, color: isDark ? Colors.green.shade400 : Colors.green.shade800)),
          ],
        ),
      ),
    );
  }

  Widget _emergencyCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFEC5C9E),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emergency\nAssistance',
            style: TextStyle(fontSize: 27, height: 1.15, fontWeight: FontWeight.w900, color: Colors.white),
          ),
          const SizedBox(height: 14),
          const Text(
            'Need immediate help? Our vets are available 24/7 via video chat.',
            style: TextStyle(fontSize: 15, height: 1.4, color: Colors.white),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const VetChatScreen()));
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.orange.shade300,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: const Text('Start Vet Chat'),
          ),
          const SizedBox(height: 24),
          Container(
            height: 128,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(18),
              gradient: RadialGradient(
                colors: [Colors.red.shade700, Colors.black],
                radius: 0.9,
              ),
            ),
            child: const Center(
              child: Text(
                'EMERGENCY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _book(String title, String price) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingCheckoutScreen(serviceName: title, price: price),
      ),
    );
  }
}
