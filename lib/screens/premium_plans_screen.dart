import 'package:flutter/material.dart';
import 'booking_checkout_screen.dart';

class PremiumPlansScreen extends StatelessWidget {
  const PremiumPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      _Plan(
        name: 'Free',
        price: 'Rs 0',
        tagline: 'For everyday animal helpers',
        color: Colors.grey,
        features: [
          'Browse adoption listings',
          'Emergency rescue reporting',
          'Basic care map access',
        ],
      ),
      _Plan(
        name: 'Silver',
        price: 'Rs 199/mo',
        tagline: 'More support for regular care',
        color: Colors.blueGrey,
        features: [
          'Priority vet chat window',
          '5% off grooming bookings',
          'Monthly care reminders',
        ],
      ),
      _Plan(
        name: 'Gold',
        price: 'Rs 499/mo',
        tagline: 'Premium care and faster support',
        color: Colors.amber,
        features: [
          'Fastest vet response queue',
          '15% off services',
          'One free wellness check monthly',
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7FBF7),
      appBar: AppBar(title: const Text('Vetaura Plans')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        itemCount: plans.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final plan = plans[index];
          final isGold = plan.name == 'Gold';

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: isGold
                  ? LinearGradient(
                      colors: [Colors.amber.shade300, Colors.orange.shade400],
                    )
                  : null,
              color: isGold ? null : Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: plan.color.withOpacity(0.16),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isGold
                            ? Colors.white.withOpacity(0.22)
                            : plan.color.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isGold ? Icons.workspace_premium : Icons.star_rounded,
                        color: isGold ? Colors.white : plan.color.shade600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: isGold ? Colors.white : const Color(0xFF2D3748),
                            ),
                          ),
                          Text(
                            plan.tagline,
                            style: TextStyle(
                              color: isGold ? Colors.white : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      plan.price,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: isGold ? Colors.white : plan.color.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ...plan.features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: isGold ? Colors.white : Colors.teal,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: isGold ? Colors.white : Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: isGold ? Colors.white : plan.color.shade600,
                      foregroundColor: isGold ? Colors.orange.shade700 : Colors.white,
                    ),
                    onPressed: plan.name == 'Free'
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookingCheckoutScreen(
                                  serviceName: 'Vetaura ${plan.name}',
                                  price: plan.price,
                                ),
                              ),
                            );
                          },
                    child: Text(plan.name == 'Free' ? 'Current Plan' : 'Choose ${plan.name}'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Plan {
  final String name;
  final String price;
  final String tagline;
  final MaterialColor color;
  final List<String> features;

  const _Plan({
    required this.name,
    required this.price,
    required this.tagline,
    required this.color,
    required this.features,
  });
}
