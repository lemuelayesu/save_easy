import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('assets/illustrations/circleavatar.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: color.primary,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: color.onSurface,
                        size: 18,
                      ),
                      onPressed: () {
                        // Navigate to edit profile picture screen
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // User Name Section
            // Removed edit icon from user name
            Center(
              // Center the username
              child: Text(
                'Lemuel Ayesu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Settings List Section
            Expanded(
              child: ListView(
                children: [
                  _buildSettingTile(
                      'Edit Profile Name', Icons.person, () {}, color),
                  const Divider(),
                  _buildSettingTile(
                      'Change Password', Icons.lock, () {}, color),
                  const Divider(),
                  _buildSettingTile(
                      'Change Email Address', Icons.email, () {}, color),
                  const Divider(),
                  _buildSettingTile('Settings', Icons.settings, () {}, color),
                  const Divider(),
                  _buildSettingTile('Preferences', Icons.tune, () {}, color),
                  const Divider(),
                  // Logout Tile without right arrow
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: color.onSurface,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: color.onSurface),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build a settings tile (with right arrow)
  Widget _buildSettingTile(
      String title, IconData icon, VoidCallback onTap, ColorScheme color) {
    return ListTile(
      leading: Icon(
        icon,
        color: color.onSurface,
      ),
      title: Text(
        title,
        style: TextStyle(color: color.onSurface),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: color.onSurface,
      ),
      onTap: onTap,
    );
  }
}
