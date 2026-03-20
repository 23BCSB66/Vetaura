import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';

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
              color: Colors.white.withOpacity(0.92),

              child: SingleChildScrollView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// DRAG HANDLE
                    Center(
                      child: Container(
                        width: 45,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 22),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    /// HEADER
                    Row(
                      children: [

                        /// ANIMATED AVATAR
                        ScaleTransition(
                          scale: avatarAnimation,

                          child: Stack(
                            children: [

                              CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.teal.shade100,
                                child: Icon(
                                  Icons.pets,
                                  size: 42,
                                  color: Colors.teal.shade700,
                                ),
                              ),

                              /// PHOTO EDIT BUTTON
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    _showPhotoOptions(context);
                                  },

                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
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

                        /// USER INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                user.username,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                "Animal Welfare Hero 🐾",
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ElevatedButton(
                          child: const Text("Edit"),
                          onPressed: () {
                            _editProfile(context);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// USER DETAILS
                    const Text(
                      "Profile Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _profileField("Name", user.username),
                    _profileField("Email", "user@email.com"),
                    _profileField("Phone", "+91 9876543210"),
                    _profileField("Gender", "Male"),
                    _profileField("Date of Birth", "01 Jan 2000"),
                    _profileField("City", "Bhubaneswar"),

                    const SizedBox(height: 30),

                    /// STATS
                    const Text(
                      "Activity Stats",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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

                    /// DONATION HISTORY
                    const Text(
                      "Recent Donations",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    _historyTile("₹250 donated", "Food for 5 strays"),
                    _historyTile("₹500 donated", "Vaccination support"),

                    const SizedBox(height: 20),

                    /// RESCUE CASES
                    const Text(
                      "Rescue Cases Submitted",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
                        onPressed: () {},
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

  /// PHOTO OPTIONS
  void _showPhotoOptions(BuildContext context) {

    showModalBottomSheet(
      context: context,

      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [

              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Take Photo"),
              ),

              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Choose from Gallery"),
              ),

            ],
          ),
        );
      },
    );
  }

  /// EDIT PROFILE
  void _editProfile(BuildContext context) {

    final controller = TextEditingController();

    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Username"),

          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter username",
            ),
          ),

          actions: [

            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),

            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {

                context.read<UserProfile>()
                    .updateUsername(controller.text);

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _profileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Row(
        children: [

          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyTile(String title, String subtitle) {

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.pets),
      title: Text(title),
      subtitle: Text(subtitle),
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

    return Container(
      width: 95,
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [

          Icon(icon, color: Colors.teal),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),

        ],
      ),
    );
  }
}