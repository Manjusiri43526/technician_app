import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/provider/profile_provider.dart';
import 'profile_page_provider.dart';

class ProfilePageProvider with ChangeNotifier {
  // Function to handle navigation based on selected menu item
  void navigateTo(BuildContext context, String title) {
    switch (title) {
      case 'Saved Addresses':
      // Navigate to Saved Addresses
        break;
      case 'Subscription':
      // Navigate to Subscription
        break;
      case 'Refer and Earn':
      // Navigate to Refer and Earn Page
        break;
      case 'Terms and Conditions':
      // Navigate to Terms and Conditions Page
        break;
      case 'Support':
      // Navigate to Support Page
        break;
      default:
        print('Tapped on $title');
    }
  }

  // Show the Logout Confirmation Dialog
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                // Clear the profile and perform logout
                Provider.of<ProfileProvider>(context, listen: false).clearProfile();
                Navigator.of(context).pop();
                print('Logged out');
              },
            ),
          ],
        );
      },
    );
  }
}
