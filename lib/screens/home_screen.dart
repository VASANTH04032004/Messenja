import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

}

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messager'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message, size: 100, color: Colors.blue),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Once you start a new conversation, you'll see it listed here",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.to(() => NewConversationScreen());
              },
              icon: Icon(Icons.chat),
              label: Text('Start chat'),
            ),
          ),
        ],
      ),
    );
  }
}

class NewConversationScreen extends GetView<HomeController> {
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
              padding: const EdgeInsets.only(top: 20.0),
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

void main() {
  runApp(
    GetMaterialApp(
      home: HomeScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
  );
}
