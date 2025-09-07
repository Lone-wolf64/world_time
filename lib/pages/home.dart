import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    final args = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments;

    if (args is Map<String, dynamic>) {
      data = args;
    } else {
      data = {
        'location': 'Unknown',
        'time': '--:--',
      };
    }

    print(data);
    // set background
    Object bgImage = data['isDayTime'] ? 'https://t3.ftcdn.net/jpg/02/59/42/54/360_F_259425456_nuW385z4eGarWkyeSs0aLcvgB2vP7yul.jpg':'https://tse2.mm.bing.net/th/id/OIP.ngYp4p58FblTg6qbFkqsmQHaEo?pid=Api&P=0&h=180';
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('$bgImage'),
            fit: BoxFit.cover,)
          ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
          child: Column(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: ()  async{
                 dynamic result = await Navigator.pushNamed(context, '/location');
                 setState(() {
                   data = {
                     'time' : result['time'],
                     'location' : result['location'],
                     'isDayTime' : result['isDayTime'],
                     'flag' : result['flag'],

                   };
                 });
                },
                icon: Icon(Icons.edit_location,color: Colors.grey[600],),
                label: Text('Location',style: TextStyle(color: Colors.grey[600]),),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                      color: Colors.cyan[200],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.cyan[200]

                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
