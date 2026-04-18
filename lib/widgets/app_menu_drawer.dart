import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/booking_checkout_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/premium_plans_screen.dart';
import '../screens/premium_services_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/vet_chat_screen.dart';
import '../services/auth_service.dart';

class AppMenuDrawer extends StatelessWidget {
  const AppMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final services = [
      ('Hair Trimming', 'Rs 399'),
      ('Bathing Session', 'Rs 349'),
      ('Deworming Session', 'Rs 299'),
      ('Nail Clipping', 'Rs 199'),
      ('Ear Cleaning', 'Rs 249'),
      ('Full Grooming Combo', 'Rs 899'),
    ];

    return Drawer(
      backgroundColor: colorScheme.surface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          children: [
            const Text(
              'Vetaura',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            const Text(
              'Care, rescue, adoption, and wellness.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 22),
            _tile(
              context,
              'Profile',
              Icons.person_outline_rounded,
              const EditProfileScreen(),
            ),
            _tile(
              context,
              'Subscription',
              Icons.workspace_premium_outlined,
              const PremiumPlansScreen(),
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              leading: Icon(
                Icons.miscellaneous_services_outlined,
                color: colorScheme.primary,
              ),
              title: const Text(
                'Services',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              children: [
                for (final service in services)
                  ListTile(
                    dense: false,
                    visualDensity: const VisualDensity(vertical: -2),
                    minLeadingWidth: 12,
                    leading: Icon(
                      Icons.arrow_right_rounded,
                      color: colorScheme.primary,
                    ),
                    title: Text(
                      service.$1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Text(
                      service.$2,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withOpacity(0.62),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingCheckoutScreen(
                            serviceName: service.$1,
                            price: service.$2,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
            _tile(
              context,
              'Settings',
              Icons.settings_outlined,
              const SettingsScreen(),
            ),
            _tile(
              context,
              'Veterinary',
              Icons.health_and_safety_outlined,
              const VetChatScreen(),
            ),
            const SizedBox(height: 18),
            const Divider(),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.logout_rounded,
                color: Color(0xFFD83A3A),
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD83A3A),
                ),
              ),
              onTap: () async {
                await context.read<AuthService>().signOut();
                if (!context.mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const LandingScreen(),
                  ),
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, String title, IconData icon, Widget screen) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
    );
  }
}
