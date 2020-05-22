import 'package:appChat/widgets/chat/message_bobble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<FirebaseUser>(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final user = snapshot.data;
            return StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('chat')
                    .orderBy(
                      'createdAt',
                      descending: true,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final document = snapshot.data.documents;

                  return ListView.builder(
                    reverse: true,
                    itemCount: document.length,
                    itemBuilder: (ctx, index) => MessageBobble(
                      document[index]['text'],
                      document[index]['userId'] == user.uid,
                      document[index]['username'],
                      document[index]['userImage'],
                      key: ValueKey(document[index].documentID),
                    ),
                  );
                });
          }),
    );
  }
}
