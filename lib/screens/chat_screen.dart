import 'package:chat_bot/widgets/bot_message.dart';
import 'package:chat_bot/widgets/user_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final messageController = TextEditingController();
  final chatMessages = FirebaseFirestore.instance.collection('chat_messages');
  bool _isThinking = false;
  final  scrollController = ScrollController();
  Future<void> sendMessage() async {
    _isThinking = true;

    final model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash-lite',
    );

    await chatMessages.add({
      'sender': 'user',
      'text': messageController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    final prompt = [Content.text(messageController.text)];
    

    final response = await model.generateContent(prompt);

    await chatMessages.add({
      'sender': 'system',
      'text': response.text ?? "I'm sorry, I couldn't understand that.",
      'timestamp': FieldValue.serverTimestamp(),
    });

    _isThinking = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatting Screen",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: chatMessages.orderBy('timestamp').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: 12,horizontal: 9),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: BotMessage(
                          message: "Hi there! I'm your AI assistant. How can I help you today?",
                        ),
                      ),
                    );
                  }

                  final data = snapshot.data!.docs;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollController.hasClients) {
                      scrollController.jumpTo(
                        scrollController.position.maxScrollExtent,
                      );
                    }
                  });
                  return ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    itemCount:
                        data.length +
                        (_isThinking ? 1 : 0), // 👈 add loader slot
                    itemBuilder: (context, index) {
                      // show loader at end if thinking
                      if (_isThinking && index == data.length) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: BotMessage(message: "Thinking..."),
                        );
                      }

                      final messageData = data[index];
                      final isSender = messageData['sender'] == 'user';
                      final message = messageData['text'];

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 9),
                        child: Align(
                          alignment: isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: isSender
                              ? UserMessage(message: message)
                              : BotMessage(message: message),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Input Field
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: IconButton(
                        onPressed: () {
                          setState(() {});
                          sendMessage().then((_){
                          messageController.clear();
                          });
                          
                        },
                        icon: Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    messageController.dispose();
  }
}
