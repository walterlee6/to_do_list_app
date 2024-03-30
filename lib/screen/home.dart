import 'package:flutter/material.dart';
import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/screen/add_note_screen.dart';
import 'package:to_do_list/widgets/stream_note.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'login.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      appBar: AppBar(
        title: Text('To Do List App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut(); // Sign out the current user
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogIN_Screen(() {})),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Add_creen(),
          ));
        },
        backgroundColor: custom_green,
        child: Icon(Icons.add, size: 30),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            // Implement your scroll logic here if needed
            return true;
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stream_note(false),
                      Stream_note(true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
