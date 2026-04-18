import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AvatarKind { asset, cartoon }

class AvatarOption {
  final String id;
  final String label;
  final AvatarKind kind;
  final String? assetPath;
  final IconData? icon;
  final List<Color> colors;

  const AvatarOption.asset({
    required this.id,
    required this.label,
    required this.assetPath,
  })  : kind = AvatarKind.asset,
        icon = null,
        colors = const [];

  const AvatarOption.cartoon({
    required this.id,
    required this.label,
    required this.icon,
    required this.colors,
  })  : kind = AvatarKind.cartoon,
        assetPath = null;
}

class UserProfile extends ChangeNotifier {
  static const _usernameKey = 'user_username';
  static const _emailKey = 'user_email';
  static const _phoneKey = 'user_phone';
  static const _genderKey = 'user_gender';
  static const _dobKey = 'user_dob';
  static const _cityKey = 'user_city';
  static const _bioKey = 'user_bio';
  static const _avatarIdKey = 'user_avatar_id';
  static const _darkModeKey = 'settings_dark_mode';
  static const _notificationsKey = 'settings_notifications';
  static const _locationAccessKey = 'settings_location_access';
  static const _emailUpdatesKey = 'settings_email_updates';
  static const _emergencyAlertsKey = 'settings_emergency_alerts';
  static const _biometricLockKey = 'settings_biometric_lock';

  static const List<AvatarOption> avatarOptions = [
    AvatarOption.asset(
      id: 'pet_beagle',
      label: 'Happy Beagle',
      assetPath: 'assets/images/hero_pet.jpg',
    ),
    AvatarOption.asset(
      id: 'pet_calm_dog',
      label: 'Calm Pup',
      assetPath: 'assets/images/pexels-adityasanjay97-2579504.jpg',
    ),
    AvatarOption.asset(
      id: 'pet_curious_cat',
      label: 'Curious Cat',
      assetPath: 'assets/images/pexels-delot-31440990.jpg',
    ),
    AvatarOption.asset(
      id: 'pet_rescue_dog',
      label: 'Rescue Buddy',
      assetPath: 'assets/images/pexels-mohammed-asaad-896403946-28543974.jpg',
    ),
    AvatarOption.asset(
      id: 'pet_street_friend',
      label: 'Street Friend',
      assetPath: 'assets/images/pexels-tamhasipkhan-6601811.jpg',
    ),
    AvatarOption.cartoon(
      id: 'toon_paw',
      label: 'Paw Buddy',
      icon: Icons.pets_rounded,
      colors: [Color(0xFF34C7A3), Color(0xFF1F9D8B)],
    ),
    AvatarOption.cartoon(
      id: 'toon_cat',
      label: 'Cat Buddy',
      icon: Icons.pets_outlined,
      colors: [Color(0xFFFFB870), Color(0xFFFF8D5C)],
    ),
    AvatarOption.cartoon(
      id: 'toon_heart',
      label: 'Kind Heart',
      icon: Icons.favorite_rounded,
      colors: [Color(0xFFFF8AAE), Color(0xFFFF5E7A)],
    ),
  ];

  String _username = 'Animal Lover';
  String _email = 'animallover@vetaura.app';
  String _phone = '+91 98765 43210';
  String _gender = 'Prefer not to say';
  String _dateOfBirth = '01 Jan 2000';
  String _city = 'Bhubaneswar';
  String _bio = 'Always ready to help a stray find food, care, and safety.';
  String _avatarId = avatarOptions.first.id;
  bool _darkMode = false;
  bool _notifications = true;
  bool _locationAccess = true;
  bool _emailUpdates = true;
  bool _emergencyAlerts = true;
  bool _biometricLock = false;
  bool _isReady = false;

  UserProfile() {
    _restoreProfile();
  }

  String get username => _username;
  String get email => _email;
  String get phone => _phone;
  String get gender => _gender;
  String get dateOfBirth => _dateOfBirth;
  String get city => _city;
  String get bio => _bio;
  String get avatarId => _avatarId;
  bool get darkMode => _darkMode;
  bool get notifications => _notifications;
  bool get locationAccess => _locationAccess;
  bool get emailUpdates => _emailUpdates;
  bool get emergencyAlerts => _emergencyAlerts;
  bool get biometricLock => _biometricLock;
  bool get isReady => _isReady;

  AvatarOption get selectedAvatar => avatarOptions.firstWhere(
        (option) => option.id == _avatarId,
        orElse: () => avatarOptions.first,
      );

  Future<void> _restoreProfile() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString(_usernameKey) ?? _username;
    _email = prefs.getString(_emailKey) ?? _email;
    _phone = prefs.getString(_phoneKey) ?? _phone;
    _gender = prefs.getString(_genderKey) ?? _gender;
    _dateOfBirth = prefs.getString(_dobKey) ?? _dateOfBirth;
    _city = prefs.getString(_cityKey) ?? _city;
    _bio = prefs.getString(_bioKey) ?? _bio;

    final savedAvatarId = prefs.getString(_avatarIdKey);
    if (savedAvatarId != null &&
        avatarOptions.any((option) => option.id == savedAvatarId)) {
      _avatarId = savedAvatarId;
    }

    _darkMode = prefs.getBool(_darkModeKey) ?? _darkMode;
    _notifications = prefs.getBool(_notificationsKey) ?? _notifications;
    _locationAccess = prefs.getBool(_locationAccessKey) ?? _locationAccess;
    _emailUpdates = prefs.getBool(_emailUpdatesKey) ?? _emailUpdates;
    _emergencyAlerts =
        prefs.getBool(_emergencyAlertsKey) ?? _emergencyAlerts;
    _biometricLock = prefs.getBool(_biometricLockKey) ?? _biometricLock;
    _isReady = true;
    notifyListeners();
  }

  Future<void> _persistProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, _username);
    await prefs.setString(_emailKey, _email);
    await prefs.setString(_phoneKey, _phone);
    await prefs.setString(_genderKey, _gender);
    await prefs.setString(_dobKey, _dateOfBirth);
    await prefs.setString(_cityKey, _city);
    await prefs.setString(_bioKey, _bio);
    await prefs.setString(_avatarIdKey, _avatarId);
    await prefs.setBool(_darkModeKey, _darkMode);
    await prefs.setBool(_notificationsKey, _notifications);
    await prefs.setBool(_locationAccessKey, _locationAccess);
    await prefs.setBool(_emailUpdatesKey, _emailUpdates);
    await prefs.setBool(_emergencyAlertsKey, _emergencyAlerts);
    await prefs.setBool(_biometricLockKey, _biometricLock);
  }

  void updateUsername(String newName) {
    _username = newName.trim().isEmpty ? _username : newName.trim();
    _persistProfile();
    notifyListeners();
  }

  void updateProfile({
    required String username,
    required String email,
    required String phone,
    required String gender,
    required String dateOfBirth,
    required String city,
    required String bio,
    required String avatarId,
  }) {
    _username = username.trim().isEmpty ? _username : username.trim();
    _email = email.trim();
    _phone = phone.trim();
    _gender = gender.trim();
    _dateOfBirth = dateOfBirth.trim();
    _city = city.trim();
    _bio = bio.trim();
    _avatarId = avatarOptions.any((option) => option.id == avatarId)
        ? avatarId
        : _avatarId;
    _persistProfile();
    notifyListeners();
  }

  void updateSettings({
    bool? darkMode,
    bool? notifications,
    bool? locationAccess,
    bool? emailUpdates,
    bool? emergencyAlerts,
    bool? biometricLock,
  }) {
    _darkMode = darkMode ?? _darkMode;
    _notifications = notifications ?? _notifications;
    _locationAccess = locationAccess ?? _locationAccess;
    _emailUpdates = emailUpdates ?? _emailUpdates;
    _emergencyAlerts = emergencyAlerts ?? _emergencyAlerts;
    _biometricLock = biometricLock ?? _biometricLock;
    _persistProfile();
    notifyListeners();
  }
}
