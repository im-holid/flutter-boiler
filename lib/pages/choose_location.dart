import 'package:flutter/material.dart';
import 'package:hiro_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(
      url: 'Europe/London',
      location: 'London',
    ),
    WorldTime(
      url: 'Europe/Berlin',
      location: 'Athens',
    ),
    WorldTime(
      url: 'Africa/Cairo',
      location: 'Cairo',
    ),
    WorldTime(
      url: 'Africa/Nairobi',
      location: 'Nairobi',
    ),
    WorldTime(
      url: 'America/Chicago',
      location: 'Chicago',
    ),
    WorldTime(
      url: 'America/New_York',
      location: 'New York',
    ),
    WorldTime(
      url: 'Asia/Seoul',
      location: 'Seoul',
    ),
    WorldTime(
      url: 'Asia/Jakarta',
      location: 'Jakarta',
    ),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    final navigator = Navigator.of(context);
    await instance.getTime();
    navigator.pop({
      'location': instance.location,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location!),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.black26,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
