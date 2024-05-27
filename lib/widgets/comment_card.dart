// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CommentCard extends StatelessWidget {
//   final snap;
//   const CommentCard({super.key, required this.snap});
  
//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             backgroundImage: NetworkImage(
//               'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
//             ),
//             radius: 18,
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   RichText(
//                     text: const TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'Yusif\n',
//                           style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
//                         ),
//                         TextSpan(
//                           text:  'Comment1',
//                           style: TextStyle(color: Colors.black)
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 4),
//                     child: Text(
//                       DateFormat.yMMMd().format(
//                         DateTime.now()
//                       ),
//                       style: const TextStyle(
//                           fontSize: 12, fontWeight: FontWeight.w400,),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(8),
//             child: const Icon(
//               Icons.favorite,
//               size: 16,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
