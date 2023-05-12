import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiro_app/model/index.dart';
import 'package:hiro_app/riverpod/auth_token.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Map data = {};

  @override
  Widget build(BuildContext context) {
    // set background image
    Color bgColor = Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black12),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {},
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[SectionUser()],
                ),
                const SizedBox(height: 20.0),
                const Text('dfjksbnhjbdsjhds',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionUser extends ConsumerStatefulWidget {
  const SectionUser({super.key});

  @override
  ConsumerState<SectionUser> createState() => _SectionUserState();
}

class _SectionUserState extends ConsumerState<SectionUser> {
  @override
  Widget build(BuildContext context) {
    final MemberDetail user = ref.watch(memberProvider);
    return Text(
      user.fullname ?? '',
      style: const TextStyle(
        fontSize: 12.0,
        letterSpacing: 2.0,
        color: Colors.white,
      ),
    );
  }
}
