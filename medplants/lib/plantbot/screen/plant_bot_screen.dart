// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// import 'package:medplants/plantbot/model/plant_message.dart';
// import 'package:medplants/plantbot/widget/threedots.dart';
// import 'package:velocity_x/velocity_x.dart';

// class PlantBotScreen extends StatefulWidget {
//   const PlantBotScreen({Key? key});

//   @override
//   State<PlantBotScreen> createState() => _PlantBotScreenState();
// }

// class _PlantBotScreenState extends State<PlantBotScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<PlantBotMessage> _messages = [];
//   late OpenAI chatGPT;
//   bool _isImgSearch = false;
//   bool _isTyping = false;

//   @override
//   void initState() {
//     chatGPT = OpenAI.instance.build(
//         token:
//             dotenv.env["api-key"],
//         baseOption: HttpSetup(receiveTimeout: Duration(seconds: 60000)));

//     super.initState();
//   }

//   @override
//   void dispose() {
//     chatGPT.close();
//     super.dispose();
//   }

//   void _sendMessage() async {
//     if (_controller.text.isEmpty) return;
//     PlantBotMessage message = PlantBotMessage(
//       text: _controller.text,
//       sender: "user",
//       isSearch: false,
//     );

//     setState(() {
//       _messages.insert(0, message);
//       _isTyping = true;
//     });

//     _controller.clear();

//     if (_isImgSearch) {
//       final request = GenerateImage(message.text, 1, size: "256x256");
//       final response = await chatGPT.generateImage(request);
//       Vx.log(response!.data!.last!.url!);
//       insertNewData(response.data!.last!.url!, isImage: true);
//     } else {
//       final request = CompleteText(prompt: message.text, model: kChatGptTurbo);
//       final response = await chatGPT.onCompletion(request: request);
//       Vx.log(response!.choices[0].text);
//       insertNewData(response.choices[0].text, isImage: false);
//     }
//   }

//   void insertNewData(String response, {bool isImage = false}) {
//     PlantBotMessage botMessage = PlantBotMessage(
//       text: response,
//       sender: "bot",
//       isSearch: isImage,
//     );

//     setState(() {
//       _isTyping = false;
//       _messages.insert(0, botMessage);
//     });
//   }

//   Widget _buildTextComposer() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _controller,
//             onSubmitted: (value) => _sendMessage(),
//             decoration: const InputDecoration.collapsed(
//               hintText: "Question/description",
//             ),
//           ),
//         ),
//         ButtonBar(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.send),
//               onPressed: () {
//                 _isImgSearch = false;
//                 _sendMessage();
//               },
//             ),
//             TextButton(
//               onPressed: () {
//                 _isImgSearch = true;
//                 _sendMessage();
//               },
//               child: const Text("Generate Image"),
//             ),
//           ],
//         ),
//       ],
//     ).px16();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("ChatGPT & Dall-E2 Demo")),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Flexible(
//               child: ListView.builder(
//                 reverse: true,
//                 padding: Vx.m8,
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) {
//                   return _messages[index];
//                 },
//               ),
//             ),
//             if (_isTyping) const ThreeDots(),
//             const Divider(
//               height: 1.0,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: context.cardColor,
//               ),
//               child: _buildTextComposer(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
