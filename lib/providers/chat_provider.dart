import 'package:flutter/foundation.dart';
import '../services/deepseek_service.dart';

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatProvider with ChangeNotifier {
  final DeepSeekService _deepSeekService = DeepSeekService();
  final List<Message> _messages = [];
  bool _isLoading = false;
  String _bookTitle = '';

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  void setBookTitle(String title) {
    _bookTitle = title;
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    // Add user message
    _messages.add(Message(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    notifyListeners();

    // Set loading state
    _isLoading = true;
    notifyListeners();

    try {
      // Get AI response
      final response = await _deepSeekService.sendMessage(text, _bookTitle);

      // Add AI message
      _messages.add(Message(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      // Add error message
      _messages.add(Message(
        text: 'Қате орын алды: $e',
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}
