

import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  // StreamController يعمل كمذياع يبث التحديثات لكل الشاشات
  final _controller = StreamController<int>.broadcast();

  Stream<int> get queueStream => _controller.stream;

  void connect(int patientId) {
    // الاتصال بالسيرفر (استخدمنا عنوان افتراضي للمشروع)
    final url = Uri.parse('ws://192.168.1.100:8004/ws/patient/$patientId');
    
    try {
      _channel = WebSocketChannel.connect(url);
      
      _channel!.stream.listen(
        (message) {
          // استقبال الرسالة وتحويلها لرقم الدور الجديد
          final data = jsonDecode(message);
          if (data['type'] == 'queue_update') {
            _controller.add(data['patients_ahead']);
          }
        },
        onError: (error) => print("خطأ في الاتصال: $error"),
        onDone: () => print("انقطع الاتصال بالسيرفر"),
      );
    } catch (e) {
      print("فشل الاتصال: $e");
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _controller.close();
  }
}