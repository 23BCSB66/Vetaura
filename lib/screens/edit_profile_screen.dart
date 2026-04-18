import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';
import '../widgets/profile_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController dobController;
  late final TextEditingController cityController;
  late final TextEditingController bioController;
  late String selectedGender;
  late String selectedAvatarId;

  static const List<String> _genderOptions = [
    'Female',
    'Male',
    'Non-binary',
    'Prefer not to say',
  ];

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProfile>();
    nameController = TextEditingController(text: user.username);
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phone);
    dobController = TextEditingController(text: user.dateOfBirth);
    cityController = TextEditingController(text: user.city);
    bioController = TextEditingController(text: user.bio);
    selectedGender = user.gender;
    selectedAvatarId = user.avatarId;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    cityController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProfile>();
    final selectedAvatar = UserProfile.avatarOptions.firstWhere(
      (option) => option.id == selectedAvatarId,
      orElse: () => UserProfile.avatarOptions.first,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF8),
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  ProfileAvatar(
                    avatar: selectedAvatar,
                    radius: 44,
                    showRing: true,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Choose your profile photo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 116,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: UserProfile.avatarOptions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final option = UserProfile.avatarOptions[index];
                  final isSelected = option.id == selectedAvatarId;
                  return GestureDetector(
                    onTap: () => setState(() => selectedAvatarId = option.id),
                    child: Container(
                      width: 92,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.teal
                              : Colors.grey.withOpacity(0.18),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProfileAvatar(avatar: option, radius: 22),
                          const SizedBox(height: 8),
                          Text(
                            option.label,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle('Essential Info'),
            const SizedBox(height: 14),
            _buildField(nameController, 'Full name', Icons.person_outline),
            const SizedBox(height: 14),
            _buildField(
              emailController,
              'Email',
              Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 14),
            _buildField(
              phoneController,
              'Phone number',
              Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _genderOptions.contains(selectedGender)
                  ? selectedGender
                  : _genderOptions.last,
              items: _genderOptions
                  .map(
                    (gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedGender = value);
                }
              },
              decoration: _inputDecoration(
                'Gender',
                Icons.diversity_3_outlined,
              ),
            ),
            const SizedBox(height: 14),
            _buildField(
              dobController,
              'Date of birth',
              Icons.cake_outlined,
            ),
            const SizedBox(height: 14),
            _buildField(cityController, 'City', Icons.location_city_outlined),
            const SizedBox(height: 24),
            _sectionTitle('About You'),
            const SizedBox(height: 14),
            TextField(
              controller: bioController,
              maxLines: 4,
              decoration: _inputDecoration(
                'Bio',
                Icons.auto_awesome_outlined,
              ).copyWith(
                alignLabelWithHint: true,
                hintText: 'Tell people what kind of animal helper you are',
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                child: const Text("Save Changes"),
                onPressed: () {
                  user.updateProfile(
                    username: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    gender: selectedGender,
                    dateOfBirth: dobController.text,
                    city: cityController.text,
                    bio: bioController.text,
                    avatarId: selectedAvatarId,
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2D3748),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label, icon),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.teal.shade600),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.teal, width: 1.6),
      ),
    );
  }
}
