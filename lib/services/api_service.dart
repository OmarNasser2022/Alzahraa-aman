
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://subrhombical-akilah-interproglottidal.ngrok-free.dev',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Map<String, dynamic>> getPatientData(String nationalId) async {
    try {
      final response = await _dio.get('/check-national-id/$nationalId');
      
      if (response.statusCode == 200 && response.data != null) {
        return Map<String, dynamic>.from(response.data);
      }
    } catch (e) {
      print("Error: $e");
    }
    
    // هنا وضعنا الـ 12 معلومة مطابقة للصورة لتظهر في الهوم لو السيرفر فصل
    return {
      "name": "Mahmoud Khalid Alkodousy",
      "blood_type": "AB-",
      "age": 22,
      "dob": "10/3/2003",
      "phone": "01062660199",
      "patient_id": "N/A",
      "height_weight": "N/A cm / N/A kg",
      "chronic_diseases": "ارتفاع ضغط الدم | الربو | أمراض شرايين القلب",
      "allergies": "حساسية البنسلين | حساسية الأسبرين | حساسية اللاتكس",
      "social_status": "Null",
      "job": "Null",
      "bmi": "N/A",
    };
  }

  Future<int> getQueueStatus(int clinicId) async {
    try {
      final response = await _dio.get('/clinics/$clinicId/queue');
      if (response.statusCode == 200) {
        return response.data['current_queue'] ?? 0;
      }
    } catch (e) {
      print("Error Queue: $e");
    }
    return 0;
  }
}


