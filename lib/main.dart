// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:morphing/app/morphing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphing/app/observer/bloc_observer.dart';
import 'package:morphing/shared/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();
  await setupLocator();

  runApp(MorphingApp());
}

// For testing the link with firebase.
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'History Client',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('History Client App'),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => FirebaseFirestore.instance
//               .collection('testing')
//               .add({'timestamp': Timestamp.fromDate(DateTime.now())}),
//           child: Icon(Icons.add),
//         ),
//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('testing').snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return const SizedBox.shrink();
//             }
//             return ListView.builder(
//               itemCount: snapshot.data?.docs.length ?? 0,
//               itemBuilder: (BuildContext context, int index) {
//                 final docData = snapshot.data?.docs[index].data();
//                 // final dateTime = (docData!['timestamp']! as Timestamp).toDate();
//                 return ListTile(
//                   title: Text(docData.toString()),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HudaiApp(),
    );
  }
}

class HudaiApp extends StatefulWidget {
  const HudaiApp({Key? key}) : super(key: key);

  @override
  _HudaiAppState createState() => _HudaiAppState();
}

class _HudaiAppState extends State<HudaiApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}

// For testing the link with firebase.
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'History Client',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('History Client App'),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => FirebaseFirestore.instance
//               .collection('testing')
//               .add({'timestamp': Timestamp.fromDate(DateTime.now())}),
//           child: Icon(Icons.add),
//         ),
//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('testing').snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return const SizedBox.shrink();
//             }
//             return ListView.builder(
//               itemCount: snapshot.data?.docs.length ?? 0,
//               itemBuilder: (BuildContext context, int index) {
//                 final docData = snapshot.data?.docs[index].data();
//                 // final dateTime = (docData!['timestamp']! as Timestamp).toDate();
//                 return ListTile(
//                   title: Text(docData.toString()),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
