import 'package:flutter/material.dart';

class MessageBobble extends StatelessWidget {
  MessageBobble(this.message, this.isMe, this.username, this.userImage,
      {this.key});

  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color:
                        isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomLeft:
                          !isMe ? Radius.circular(0.0) : Radius.circular(12.0),
                      bottomRight:
                          isMe ? Radius.circular(0.0) : Radius.circular(12.0),
                    ),
                  ),
                  width: 140,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        username ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline1
                                  .color,
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline1
                                  .color,
                        ),
                      ),
                    ],
                  )),
            ]),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: !isMe ? null : 120,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
