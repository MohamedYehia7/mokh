import 'package:flutter/material.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){}, child: const Text('Invoice Details')),
          ElevatedButton(onPressed: (){}, child: const Text('Invoice list')),
        ],
      ),
    );
  }
}
