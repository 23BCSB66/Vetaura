import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/landing_screen.dart';
import '../services/auth_service.dart';
import 'profile_avatar.dart';

class ProfilePopup extends StatefulWidget {
  const ProfilePopup({super.key});

  @override
  State<ProfilePopup> createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController avatarController;
  late Animation<double> avatarAnimation;

  @override
  void initState() {
    super.initState();
    avatarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    avatarAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: avatarController,
        curve: Curves.elasticOut,
      ),
    );
    avatarController.forward();
  }

  @override
  void dispose() {
    avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProfile>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final sheetColor = isDark
        ? const Color(0xFF15211D).withOpacity(0.96)
        : Colors.white.withOpacity(0.92);
    final dividerColor =
        isDark ? Colors.white.withOpacity(0.14) : Colors.grey.shade300;
    final mutedText =
        isDark ? Colors.white.withOpacity(0.68) : Colors.black54;

    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: sheetColor,
              child: SingleChildScrollView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 45,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 22),
                        decoration: BoxDecoration(
                          color: dividerColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        ScaleTransition(
                          scale: avatarAnimation,
                          child: Stack(
                            children: [
                              ProfileAvatar(
                                avatar: user.selectedAvatar,
                                radius: 45,
                                showRing: true,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => _openEditProfile(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDark
                                            ? const Color(0xFF15211D)
                                            : Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.username,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.bio,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: mutedText,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          child: const Text("Edit"),
                          onPressed: () => _openEditProfile(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Profile Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _profileField("Name", user.username),
                    _profileField("Email", user.email),
                    _profileField("Phone", user.phone),
                    _profileField("Gender", user.gender),
                    _profileField("Date of Birth", user.dateOfBirth),
                    _profileField("City", user.city),
                    const SizedBox(height: 30),
                    Text(
                      "Activity Stats",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _StatCard("Donations", "12", Icons.volunteer_activism),
                        _StatCard("Rescues", "5", Icons.warning),
                        _StatCard("Adoptions", "2", Icons.pets),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Recent Donations",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _historyTile("Rs 250 donated", "Food for 5 strays"),
                    _historyTile("Rs 500 donated", "Vaccination support"),
                    const SizedBox(height: 20),
                    Text(
                      "Rescue Cases Submitted",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _historyTile("Injured Puppy", "Reported near Market Road"),
                    _historyTile("Bird Rescue", "Park Lane"),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text("Log Out"),
                        onPressed: () async {
                          await context.read<AuthService>().signOut();
                          if (!mounted) return;
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const LandingScreen(),
                            ),
                            (_) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _openEditProfile(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
    );
  }

  Widget _profileField(String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isDark ? Colors.white.withOpacity(0.68) : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyTile(String title, String subtitle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        Icons.pets,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDark ? Colors.white.withOpacity(0.68) : Colors.black54,
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard(this.label, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 95,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.teal.shade900.withOpacity(0.28)
            : Colors.teal.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: isDark ? Colors.teal.shade200 : Colors.teal),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72),
            ),
          ),
        ],
      ),
    );
  }
}
