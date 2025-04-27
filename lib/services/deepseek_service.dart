import 'dart:convert';
import 'package:http/http.dart' as http;

class DeepSeekService {
  static const String _baseUrl = 'https://api.deepseek.com/v1';
  static const String _apiKey = 'sk-34b4435c0a9b4556befe0ea618c6c822';

  Future<String> sendMessage(String message, String bookTitle) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'deepseek-chat',
          'messages': [
            {
              'role': 'system',
              'content':
                  'Сен кітап туралы сұрақтарға жауап беретін қазақ тіліндегі көмеkшісің. Кітап атауы: $bookTitle'
            },
            {'role': 'user', 'content': message}
          ],
          'temperature': 0.7,
          'max_tokens': 1000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('API қатесі: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('API қоңырауы сәтсіз аяқталды: $e');
    }
  }
}
