import 'package:flutter/material.dart';
import 'package:wecheck/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool changed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteName.bsLog);
        },
      ),
      body: Center(
        child: Container(
          color: Colors.yellow,
          child: Switch(
            value: changed,
            onChanged: (change) {
              setState(() {
                changed = change;
              });
            },
          ),
        ),
      ),
    );
  }
}
