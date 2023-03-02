import 'package:flutter/material.dart';

import 'ProfilePage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, this.name = 'hugo'});

  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 83, 168, 236))),
              child: const Text('Afficher le profil', style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(name: name),
                  ),
                );
              },
              
            )
          ],
        )
      )
    );
  }
}