import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> friends = [
    {"name": "Suman", "imageUrl": "https://via.placeholder.com/150"},
    {"name": "Muna", "imageUrl": "https://via.placeholder.com/150"},
    {"name": "Soniya", "imageUrl": "https://via.placeholder.com/150"},
    {"name": "Hemlata", "imageUrl": "https://via.placeholder.com/150"},
    {"name": "Ram", "imageUrl": "https://via.placeholder.com/150"},
    {"name": "Numa", "imageUrl": "https://via.placeholder.com/150"},
    {"name": "Aaryan", "imageUrl": "https://via.placeholder.com/150"},
    {"name": "Mohit", "imageUrl": "https://via.placeholder.com/150"},
    {"name": "Numa", "imageUrl": "https://via.placeholder.com/150"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 62, 33),
        title: Text(
          "TrashTreasure",
        ),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(friends[index]['imageUrl']),
                radius: 30,
              ),
              title: Text(
                friends[index]['name'],
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Message()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List<String> messages = [
    "Hello!",
    "Hi there!",
    "How are you doing?",
    "I'm doing well. How about you?",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 62, 33),
        title: Text("Chats"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 4, 98, 7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(messages[index],
                        style: TextStyle(color: Colors.white)),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text(
                      "A",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Send message logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
