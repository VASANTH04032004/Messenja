import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messenger',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message, size: 100, color: Colors.blue),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewConversationScreen()),
                );
              },
              icon: Icon(Icons.chat,color: Colors.blue,),
              label: Text('Start chat',style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }
}

class NewConversationScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New conversation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Type a name, phone number, or email',
                border: UnderlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListTile(
                leading: Icon(Icons.group_add, color: Colors.blue),
                title: Text('Create group'),
                onTap: () {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


