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

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF111A16) : const Color(0xFFF7FBF7),
      appBar: AppBar(title: const Text('Vetaura Plans')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        itemCount: plans.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final plan = plans[index];
          return _PlanCard(plan: plan);
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final _Plan plan;

  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isGold = plan.name == 'Gold';
    final isSilver = plan.name == 'Silver';

    final defaultSurface = isDark ? const Color(0xFF17231F) : Colors.white;
    final backgroundGradient = isGold
        ? [
            const Color(0xFFFFD95A),
            const Color(0xFFFFBF1F),
            const Color(0xFFFF9F0A),
          ]
        : isSilver
            ? (isDark
                ? [
                    const Color(0xFF7E8B93),
                    const Color(0xFF4F5B64),
                    const Color(0xFF353F46),
                  ]
                : [
                    const Color(0xFFF3F7FA),
                    const Color(0xFFD4DDE4),
                    const Color(0xFFA7B4BE),
                  ])
            : null;

    final titleColor = isGold
        ? Colors.white
        : isSilver
            ? (isDark ? Colors.white : const Color(0xFF233039))
            : (isDark ? Colors.white : const Color(0xFF2D3748));

    final subtitleColor = isGold
        ? Colors.white.withOpacity(0.92)
        : isSilver
            ? (isDark ? Colors.white70 : const Color(0xFF41505A))
            : (isDark ? Colors.white70 : Colors.grey.shade600);

    final accentColor = isGold
        ? Colors.white
        : isSilver
            ? (isDark ? const Color(0xFFE5EDF2) : const Color(0xFF5E6B75))
            : (isDark ? plan.color.shade300 : plan.color.shade700);

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: backgroundGradient == null
                  ? null
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: backgroundGradient,
                    ),
              color: backgroundGradient == null ? defaultSurface : null,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: isGold
                    ? Colors.white.withOpacity(0.18)
                    : isSilver
                        ? Colors.white.withOpacity(isDark ? 0.10 : 0.65)
                        : Colors.transparent,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isGold
                          ? Colors.amber
                          : isSilver
                              ? Colors.blueGrey
                              : plan.color)
                      .withOpacity(isDark ? 0.22 : 0.16),
                  blurRadius: isGold ? 26 : 18,
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
                            ? Colors.white.withOpacity(0.20)
                            : isSilver
                                ? Colors.white.withOpacity(isDark ? 0.12 : 0.58)
                                : (isDark
                                    ? plan.color.withOpacity(0.15)
                                    : plan.color.shade50),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isGold || isSilver
                              ? Colors.white.withOpacity(0.25)
                              : Colors.transparent,
                        ),
                      ),
                      child: Icon(
                        isGold
                            ? Icons.workspace_premium_rounded
                            : isSilver
                                ? Icons.shield_moon_rounded
                                : Icons.star_rounded,
                        color: isGold
                            ? Colors.white
                            : isSilver
                                ? accentColor
                                : (isDark
                                    ? plan.color.shade300
                                    : plan.color.shade600),
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
                              color: titleColor,
                            ),
                          ),
                          Text(
                            plan.tagline,
                            style: TextStyle(color: subtitleColor),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      plan.price,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: accentColor,
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
                          color: isGold
                              ? Colors.white
                              : isSilver
                                  ? accentColor
                                  : Colors.teal,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: isGold || isSilver
                                  ? subtitleColor
                                  : (isDark ? Colors.white70 : Colors.black87),
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
                      backgroundColor: isGold
                          ? Colors.white
                          : isSilver
                              ? (isDark
                                  ? Colors.white.withOpacity(0.14)
                                  : const Color(0xFF6C7A85))
                              : (isDark
                                  ? plan.color.withOpacity(0.2)
                                  : plan.color.shade600),
                      foregroundColor: isGold
                          ? const Color(0xFFD88400)
                          : isSilver
                              ? (isDark ? Colors.white : Colors.white)
                              : (isDark ? plan.color.shade200 : Colors.white),
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
                    child: Text(
                      plan.name == 'Free'
                          ? 'Current Plan'
                          : 'Choose ${plan.name}',
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isGold) ...[
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.18),
                        Colors.transparent,
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.24, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: -1.2, end: 1.4),
                  duration: const Duration(milliseconds: 2400),
                  curve: Curves.easeInOut,
                  builder: (context, value, _) {
                    return Transform.translate(
                      offset: Offset(300 * value, 0),
                      child: Transform.rotate(
                        angle: -0.35,
                        child: Container(
                          width: 84,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.0),
                                Colors.white.withOpacity(0.22),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          if (isSilver)
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(isDark ? 0.10 : 0.45),
                        Colors.transparent,
                        Colors.black.withOpacity(isDark ? 0.06 : 0.08),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),
            ),
        ],
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
