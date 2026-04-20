
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/services/api_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String patientId;
  const HomeScreen({super.key, required this.patientId});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Map<String, dynamic>? patientData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final api = ApiService();
    final data = await api.getPatientData(widget.patientId);
    if (mounted) {
      setState(() {
        patientData = data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.menu, color: Colors.blue), onPressed: () {}),
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: Colors.grey), onPressed: _fetchData),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("تسجيل خروج", style: TextStyle(color: Colors.black54))),
        ],
      ),
      body: isLoading 
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(onPressed: () {}, icon: const Icon(Icons.arrow_back, size: 16), label: const Text("back")),
                  SizedBox(height: 10.h),
                  Text("Welcome back ${patientData?['name'] ?? 'Mahmoud Khalid Alkodousy'}", 
                      style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  Text("Here's your medical summary and treatment history.", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                  
                  SizedBox(height: 30.h),

                  // الـ 12 خانة بنفس ترتيب الصورة بالضبط
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 5, // تقسييم العرض ليشبه التصميم الواسع في الصورة
                    mainAxisSpacing: 15.h,
                    crossAxisSpacing: 15.w,
                    childAspectRatio: 1.3,
                    children: [
                      _buildInfoCard(Icons.person_outline, "Full name", patientData?['name'] ?? "Mahmoud Khalid Alkodousy"),
                      _buildInfoCard(Icons.badge_outlined, "National Id", widget.patientId),
                      _buildInfoCard(Icons.phone_outlined, "Phone number", "01062660199"),
                      _buildInfoCard(Icons.person_search_outlined, "Age & Gender", "ذكر , ${patientData?['age'] ?? '22'} yrs"),
                      _buildInfoCard(Icons.calendar_month_outlined, "Date of birth", "10/3/2003"),
                      _buildInfoCard(Icons.list_alt, "Patient ID", "N/A"),
                      _buildInfoCard(Icons.water_drop_outlined, "Blood Type", patientData?['blood_type'] ?? "AB-"),
                      _buildInfoCard(Icons.monitor_heart_outlined, "Height & Weight", "N/A cm / N/A kg"),
                      // كارت الأمراض المزمنة يأخذ مساحة أكبر (عرض خانتين)
                    ],
                  ),
                  
                  SizedBox(height: 15.h),
                  
                  // الصف الثاني العريض (الأمراض والحساسية)
                  Row(
                    children: [
                      Expanded(child: _buildWideCard(Icons.favorite_border, "Chronic Diseases", "ارتفاع ضغط الدم | الربو | أمراض شرايين القلب")),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Expanded(flex: 2, child: _buildWideCard(Icons.info_outline, "Allergies", "حساسية البنسلين | حساسية الأسبرين | حساسية اللاتكس")),
                      SizedBox(width: 15.w),
                      Expanded(child: _buildInfoCard(Icons.people_outline, "Social Status", "Null")),
                      SizedBox(width: 15.w),
                      Expanded(child: _buildInfoCard(Icons.work_outline, "Job", "Null")),
                      SizedBox(width: 15.w),
                      Expanded(child: _buildInfoCard(Icons.access_time, "BMI", "N/A")),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(color: const Color(0xFF4A90F2), borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 22.sp),
          const Spacer(),
          Text(title, style: TextStyle(color: Colors.white70, fontSize: 10.sp)),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildWideCard(IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(color: const Color(0xFF4A90F2), borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 24.sp),
          SizedBox(height: 10.h),
          Text(title, style: TextStyle(color: Colors.white70, fontSize: 11.sp)),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}