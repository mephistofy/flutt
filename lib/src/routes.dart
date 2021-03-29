import 'package:flutter/material.dart';
import 'package:myapp/src/widgets/chat/chat_screen.dart';
import 'package:myapp/src/widgets/login/login_screen.dart';

final routes = {
  "/login": (BuildContext context) => new LoginScreen(),
  "/chat": (BuildContext context) => new ChatScreen(),
  "/home": (BuildContext context) => new LoginScreen(),
};
