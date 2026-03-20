import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'booking_checkout_screen.dart';

class PremiumServicesScreen extends StatelessWidget {
  const PremiumServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final services = [
      {
        'title': 'At-Home Vaccination',
        'subtitle': 'Verified vet comes to your home. Stress-free.',
        'price': '₹499',
        'icon': Icons.vaccines,
        'color': Colors.blue,
      },
      {
        'title': 'Premium Vet Consult',
        'subtitle': 'Skip the line. Includes general health checkup.',
        'price': '₹299',
        'icon': Icons.medical_services,
        'color': Colors.orange,
      },
      {
        'title': 'Pet Grooming Session',
        'subtitle': 'Full spa treatment. Safe and holistic care.',
        'price': '₹799',
        'icon': Icons.content_cut,
        'color': Colors.pink,
      },
      {
        'title': 'NGO Sponsorship',
        'subtitle': 'Sponsor a shelter\'s meal for a day.',
        'price': '₹999',
        'icon': Icons.favorite,
        'color': Colors.red,
      },
    ];

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          /// HEADER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Expanded(
                    child: Text(
                      'Vetaura Premium\nExpert care simplified',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber, Colors.orange],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// SERVICES LIST
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 110),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(

                    (context, index) {

                  final service = services[index];
                  final iconColor = service['color'] as MaterialColor;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [

                        /// ICON SECTION
                        Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            color: iconColor.shade50,
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(20),
                            ),
                          ),
                          child: Icon(
                            service['icon'] as IconData,
                            size: 40,
                            color: iconColor.shade400,
                          ),
                        ),

                        const SizedBox(width: 16),

                        /// TEXT SECTION
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  service['title'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF2D3748),
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  service['subtitle'] as String,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  service['price'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: iconColor.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// BUTTON SECTION
                        Container(
                          height: 120,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.grey.shade100),
                            ),
                          ),

                          child: Material(
                            color: Colors.transparent,

                            child: InkWell(
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(20),
                              ),

                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookingCheckoutScreen(
                                      serviceName: service['title'] as String,
                                      price: service['price'] as String,
                                    ),
                                  ),
                                );
                              },

                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: iconColor.shade400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },

                childCount: services.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}