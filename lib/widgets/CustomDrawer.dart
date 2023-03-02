
import 'package:flutter/material.dart';

import '../pages/HomePage.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
        
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Container(
                child: Text('Drawer Header'),
                )
              ),
              ListTile(
                title: Text('Menu Item 1'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text('Vous avez cliqué sur le menu item 1')));
                },
              ),
              ListTile(
                title: Text('Menu Item 2'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Menu Item 3'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Quit'),
                onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
                },
              ),
        ],
      ),
      
    ),
    );
  }
}