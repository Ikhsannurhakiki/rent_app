import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUserEntity;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Column(
        children: [
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 50,
            backgroundImage: user?.profilePictureUrl==null? NetworkImage('https://i.pravatar.cc/150?img=3') : NetworkImage(user!.profilePictureUrl.toString()),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              user!.fullName.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Username"),
            subtitle: Text(user.fullName.toString()),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text("Email"),
            subtitle: Text(auth.currentUser!.email.toString()),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text("Location"),
            subtitle: const Text("Pekanbaru, Riau"),
            trailing: const Icon(Icons.edit_location_alt),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.phone_outlined),
            title: const Text("Phone"),
            subtitle: user.phoneNumber == ''
                ? const Text("No Phone Number")
                : Text(user.phoneNumber.toString()),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
