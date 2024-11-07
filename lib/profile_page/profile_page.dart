import 'dart:io'; // Make sure you import this for FileImage
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/profile_page/edit_profile.dart';

import '../colors.dart';
import '../provider/profile_page_provider.dart';
import '../provider/profile_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile;
    final profilePageProvider = Provider.of<ProfilePageProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Profile',
          style: TextStyle(color: white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Welcome Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: profile.profileImage != null
                          ? FileImage(profile.profileImage!)
                          : const AssetImage("assets/images/profile_photo.jpg"),
                      radius: 25,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Welcome, ${profile.name}!',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfilePage()),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(profile.email, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                Text(profile.number, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                Text(profile.address, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Options Section
          _buildOptionItem(context, 'Saved Addresses', Icons.location_on_outlined, profilePageProvider),
          _buildOptionItem(context, 'Subscription', Icons.subscriptions_rounded, profilePageProvider),
          _buildOptionItem(context, 'Terms and Conditions', Icons.assignment, profilePageProvider),
          _buildOptionItem(context, 'Support', Icons.question_mark, profilePageProvider),
          _buildOptionItem(context, 'Logout', Icons.logout, profilePageProvider),
        ],
      ),
    );
  }

  // Helper to build list items
  Widget _buildOptionItem(BuildContext context, String title, IconData icon, ProfilePageProvider provider) {
    return GestureDetector(
      onTap: () {
        if (title == 'Logout') {
          provider.showLogoutDialog(context);
        } else {
          provider.navigateTo(context, title);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 18)),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
