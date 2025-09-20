import 'package:flutter/material.dart';

class CustomDrawer extends Drawer {
  CustomDrawer({
    super.key,
    required String name,
    required String email,
    required String url,
    VoidCallback? onLogOut,
  }) : super(
         child: Drawer(
           shape: RoundedRectangleBorder(),
           child: Column(
             children: [
               //Drawer Header
               UserAccountsDrawerHeader(
                 accountName: Text(name),
                 accountEmail: Text(email),
                 currentAccountPicture: CircleAvatar(
                   backgroundImage: NetworkImage(url),
                 ),
                 decoration: BoxDecoration(color: Colors.blue),
               ),

               ListTile(
                 leading: Icon(Icons.logout),
                 title: Text("Logout"),
                 onTap: onLogOut,
               ),

               // Optional: bottom aligned
               Spacer(),
               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text(
                   "Version 1.0.0",
                   style: TextStyle(color: Colors.grey),
                 ),
               ),
             ],
           ),
         ),
       );
}
