import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}
class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(location: 'London', url: 'Europe/London', flag: 'https://tse3.mm.bing.net/th/id/OIP.xZU2eaShw9o68_ShqRCFmAHaFP?pid=Api&P=0&h=180'),
    WorldTime(location: 'Berlin', url: 'Europe/Berlin', flag: 'https://tse2.mm.bing.net/th/id/OIP.hkGVLNEmw9LCsMyYk3DqAgHaE7?pid=Api&P=0&h=180'),
    WorldTime(location: 'Cairo', url: 'Africa/Cairo', flag: 'https://tse1.mm.bing.net/th/id/OIP.XKfPTAHa0mZyVRyVyGu-aAHaE8?pid=Api&P=0&h=180'),
    WorldTime(location: 'Nairobi', url: 'Africa/Nairobi', flag: 'https://tse3.mm.bing.net/th/id/OIP.KBmf2yULlVlhbOF3H4bJQgHaE8?pid=Api&P=0&h=180'),
    WorldTime(location: 'Chicago', url: 'America/Chicago', flag: 'https://tse2.mm.bing.net/th/id/OIP.bPI4eVfCHBCozykCvsS-cQHaEz?pid=Api&P=0&h=180'),
    WorldTime(location: 'India', url: 'Asia/India', flag: 'https://tse2.mm.bing.net/th/id/OIP.9YtAsanlFMBU3PoImltJpwHaFP?pid=Api&P=0&h=180'),
    WorldTime(location: 'Jakarta', url: 'Asia/Jakarta', flag: 'https://tse4.mm.bing.net/th/id/OIP.EkPR6R-A0Q3316Bv8W9o9wHaE8?pid=Api&P=0&h=180'),

  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    // navigate to home page screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onTap: (){
                updateTime(index);
              },
              title: Text(locations[index].location),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${locations[index].flag}'),
              ),
            ),
          );
        },
      itemCount: locations.length
        ,),
    );
  }
}
