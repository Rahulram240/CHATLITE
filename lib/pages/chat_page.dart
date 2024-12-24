import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p1/components/chat_bubble.dart';
import 'package:p1/components/my_textfield.dart';
import 'package:p1/services/auth/auth_service.dart';
import 'package:p1/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  FocusNode myfocusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    myfocusNode.addListener(() {
      if (myfocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myfocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Text(widget.receiverEmail),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data['message'],
              isCurrentUser: isCurrentUser,
            ),
          ],
        )
        );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type here ...",
              obscureText: false,
              focusNode: myfocusNode,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/** BELOW WE CAN PLAY**/

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:p1/components/chat_bubble.dart';
// import 'package:p1/components/my_textfield.dart';
// import 'package:p1/services/auth/auth_service.dart';
// import 'package:p1/services/chat/chat_services.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ChatPage extends StatefulWidget {
//   final String receiverEmail;
//   final String receiverID;

//   ChatPage({
//     super.key,
//     required this.receiverEmail,
//     required this.receiverID,
//   });

//   @override
//   State<StatefulWidget> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   final AuthService _authService = AuthService();
//   final ScrollController _scrollController = ScrollController();
//   FocusNode myFocusNode = FocusNode();
//   bool isOnline = true;

//   @override
//   void initState() {
//     super.initState();

//     // Focus listener for auto-scroll
//     myFocusNode.addListener(() {
//       if (myFocusNode.hasFocus) {
//         Future.delayed(
//           const Duration(milliseconds: 500),
//           scrollDown,
//         );
//       }
//     });

//     // Initial scroll to bottom
//     Future.delayed(
//       const Duration(milliseconds: 500),
//       scrollDown,
//     );

//     // Monitor connectivity
//     Connectivity().onConnectivityChanged.listen((result) {
//       setState(() {
//         isOnline = result != ConnectivityResult.none;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     myFocusNode.dispose();
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void scrollDown() {
//     if (_scrollController.hasClients &&
//         _scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent - 200) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   void sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       await _chatService.sendMessage(widget.receiverID, _messageController.text);
//       _messageController.clear();
//     }
//     scrollDown();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.grey,
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(isOnline ? Icons.circle : Icons.circle_outlined,
//                 color: isOnline ? Colors.green : Colors.red, size: 12),
//             const SizedBox(width: 8),
//             Text(widget.receiverEmail),
//           ],
//         ),
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return Column(
//               children: [
//                 Expanded(
//                   child: _buildMessageList(),
//                 ),
//                 _buildUserInput(),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageList() {
//     String senderID = _authService.getCurrentUser()!.uid;

//     return StreamBuilder(
//       stream: _chatService.getMessage(widget.receiverID, senderID),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Something went wrong"),
//                 ElevatedButton(
//                   onPressed: () => setState(() {}),
//                   child: const Text("Retry"),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return ListView(
//           controller: _scrollController,
//           children: snapshot.data!.docs
//               .map<Widget>((doc) => _buildMessageItem(doc))
//               .toList(),
//         );
//       },
//     );
//   }

//   Widget _buildMessageItem(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;
//     var alignment =
//         isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

//     return Container(
//       alignment: alignment,
//       margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//       child: Column(
//         crossAxisAlignment:
//             isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           ChatBubble(
//             message: data['message'],
//             isCurrentUser: isCurrentUser,
//           ),
//           const SizedBox(height: 5),
//           Text(
//             _formatTimestamp(data['timestamp']),
//             style: const TextStyle(fontSize: 10, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatTimestamp(Timestamp timestamp) {
//     final dateTime = timestamp.toDate();
//     final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
//     final period = dateTime.hour >= 12 ? "PM" : "AM";
//     final minute = dateTime.minute.toString().padLeft(2, '0');
//     return "$hour:$minute $period";
//   }

//   Widget _buildUserInput() {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: MyTextField(
//               controller: _messageController,
//               hintText: "Type here...",
//               obscureText: false,
//               focusNode: myFocusNode,
//             ),
//           ),
//           Container(
//             decoration: const BoxDecoration(
//               color: Colors.green,
//               shape: BoxShape.circle,
//             ),
//             margin: const EdgeInsets.only(right: 10),
//             child: IconButton(
//               onPressed: sendMessage,
//               icon: const Icon(
//                 Icons.arrow_upward,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
