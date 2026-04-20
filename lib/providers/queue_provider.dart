
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/services/api_service.dart';

// بروفايدر لمراقبة رقم الانتظار وتحديثه تلقائياً من السيرفر
final queueProvider = StreamProvider.family<int, int>((ref, clinicId) async* {
  final apiService = ApiService();

  // حلقة تكرارية لتحديث البيانات بانتظام (Real-time update)
  while (true) {
    try {
      // جلب رقم الانتظار الفعلي من الـ API
      final queueCount = await apiService.getQueueStatus(clinicId);
      yield queueCount;
    } catch (e) {
      // في حالة وجود خطأ في الشبكة، يعرض آخر قيمة أو صفر
      yield 0;
    }
    // الانتظار لمدة 10 ثوانٍ قبل التحديث القادم
    await Future.delayed(const Duration(seconds: 10));
  }
});
