import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search location...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                // neste momento nao faço nada
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Currently', style: TextStyle(fontSize: 24))),
            Center(child: Text('Today', style: TextStyle(fontSize: 24))),
            Center(child: Text('Weekly', style: TextStyle(fontSize: 24))),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.wb_sunny), text: 'Currently'),
              Tab(icon: Icon(Icons.today), text: 'Today'),
              Tab(icon: Icon(Icons.calendar_view_week), text: 'Weekly'),
            ],
          ),
        ),
      ),
    );
  }
}
