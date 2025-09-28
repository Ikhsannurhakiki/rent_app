import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              "John Doe",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Username"),
            subtitle: const Text("johndoe123"),
            trailing: const Icon(Icons.edit),
            onTap: () {
            },
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text("Email"),
            subtitle: const Text("john.doe@example.com"),
            trailing: const Icon(Icons.edit),
            onTap: () {
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text("Location"),
            subtitle: const Text("Pekanbaru, Riau"),
            trailing: const Icon(Icons.edit_location_alt),
            onTap: () {
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_outlined),
            title: const Text("Phone"),
            subtitle: const Text("+62 812 3456 7890"),
            trailing: const Icon(Icons.edit),
            onTap: () {
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
