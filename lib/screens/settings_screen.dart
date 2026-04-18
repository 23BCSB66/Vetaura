import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProfile>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          MediaQuery.of(context).padding.bottom + 24,
        ),
        children: [
          _section(context, 'General'),
          _switchTile(
            context,
            'Notifications',
            'Rescue, booking, and adoption updates',
            Icons.notifications_outlined,
            user.notifications,
            (value) => user.updateSettings(notifications: value),
          ),
          _switchTile(
            context,
            'Dark Mode',
            'Use a darker app appearance',
            Icons.dark_mode_outlined,
            user.darkMode,
            (value) => user.updateSettings(darkMode: value),
          ),
          _switchTile(
            context,
            'Location Access',
            'Help find nearby clinics and shelters',
            Icons.location_on_outlined,
            user.locationAccess,
            (value) => user.updateSettings(locationAccess: value),
          ),
          _section(context, 'Communication'),
          _switchTile(
            context,
            'Email Updates',
            'Receive summaries and care reminders',
            Icons.email_outlined,
            user.emailUpdates,
            (value) => user.updateSettings(emailUpdates: value),
          ),
          _switchTile(
            context,
            'Emergency Alerts',
            'Notify me about nearby urgent cases',
            Icons.warning_amber_rounded,
            user.emergencyAlerts,
            (value) => user.updateSettings(emergencyAlerts: value),
          ),
          _section(context, 'Privacy & App'),
          _switchTile(
            context,
            'Biometric Lock',
            'Require device unlock for profile access',
            Icons.fingerprint_rounded,
            user.biometricLock,
            (value) => user.updateSettings(biometricLock: value),
          ),
          _actionTile(context, 'Language', 'English', Icons.language_rounded),
          _actionTile(
            context,
            'Help & Support',
            'FAQs, contact, and safety guidance',
            Icons.help_outline_rounded,
          ),
          _actionTile(
            context,
            'About Vetaura',
            'Version 1.0.0',
            Icons.info_outline,
          ),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 18, 4, 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _switchTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        secondary: Icon(icon, color: colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _actionTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ),
    );
  }
}
