import 'package:flutter/material.dart';
import 'cau1/views/register_view.dart';
import 'cau2/views/personal_info_view.dart';
import 'cau3/views/survey_view.dart';
import 'cau4/views/booking_view.dart';
import 'cau5/views/upload_view.dart';
import 'cau10/views/basic_register_view.dart';
import 'cau11/views/login_view.dart';
import 'cau13/views/feedback_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài Tập Chương 6',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh Sách Bài Tập',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // THANH MSSV
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.indigo.withOpacity(0.1),
            child: const Text(
              'MSSV: 6451071018',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                letterSpacing: 1.2,
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0, left: 8.0),
                  child: Text(
                    'Các bài đã hoàn thành',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                _buildMenuCard(
                  context,
                  title: 'Bài 1: Form Đăng Ký Cơ Bản',
                  subtitle: 'TextFormField, Checkbox, Validate',
                  icon: Icons.person_add_alt_1_rounded,
                  iconColor: const Color(0xFF0D9488),
                  targetPage: const RegisterView(),
                  isActive: true,
                ),
                _buildMenuCard(
                  context,
                  title: 'Bài 2: Form Thông Tin Cá Nhân',
                  subtitle: 'Dropdown, Radio, Slider',
                  icon: Icons.contact_mail_rounded,
                  iconColor: const Color(0xFF2563EB),
                  targetPage: const PersonalInfoView(),
                  isActive: true,
                ),
                _buildMenuCard(
                  context,
                  title: 'Bài 3: Giao Diện Form Khảo Sát',
                  subtitle: 'CheckboxListTile, Radio, Snackbar',
                  icon: Icons.poll_rounded,
                  iconColor: const Color(0xFF7C3AED),
                  targetPage: const SurveyView(),
                  isActive: true,
                ),
                _buildMenuCard(
                  context,
                  title: 'Bài 4: Form Đặt Lịch Hẹn',
                  subtitle: 'DatePicker, TimePicker, Dropdown',
                  icon: Icons.calendar_month_rounded,
                  iconColor: const Color(0xFF4F46E5),
                  targetPage: const BookingView(),
                  isActive: true,
                ),
                _buildMenuCard(
                  context,
                  title: 'Bài 5: Form Upload Hồ Sơ',
                  subtitle: 'File Picker, Form Validate',
                  icon: Icons.upload_file_rounded,
                  iconColor: const Color(0xFF0F766E), // Cập nhật màu xanh Teal
                  targetPage: const UploadView(), // Trỏ tới form mới tạo
                  isActive: true, // Mở khoá chức năng
                ),
                _buildMenuCard(
                  context,
                  title: 'Bài 10: Form Đăng Ký Cơ Bản',
                  subtitle: 'Validate realtime, Error Text dưới field',
                  icon: Icons.app_registration_rounded,
                  iconColor: const Color(0xFFE11D48), // Màu Rose
                  targetPage: const BasicRegisterView(),
                  isActive: true,
                ),
                _buildMenuCard(
                  context,
                  title: 'Bài 11: Form Login Có Styling',
                  subtitle: 'InputDecorationTheme, Validate on submit',
                  icon: Icons.login_rounded,
                  iconColor: Colors.deepPurple,
                  targetPage: const LoginView(),
                  isActive: true,
                ),
                _buildMenuCard(
                  context,
                  title: 'Bài 13: Form Phản Hồi',
                  subtitle: 'Validate realtime khi đang gõ (onUserInteraction)',
                  icon: Icons.feedback_rounded,
                  iconColor: const Color(0xFFF57C00), // Màu cam
                  targetPage: const FeedbackView(),
                  isActive: true,
                ),

                // const Padding(
                //   padding: EdgeInsets.only(top: 24.0, bottom: 16.0, left: 8.0),
                //   child: Text(
                //     'Các bài sắp tới',
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Widget? targetPage,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isActive ? iconColor.withOpacity(0.1) : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isActive ? iconColor : Colors.grey,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isActive ? Colors.black87 : Colors.grey,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: isActive ? Colors.black54 : Colors.grey,
            ),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: isActive ? Colors.grey[400] : Colors.transparent,
          size: 18,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: isActive && targetPage != null
            ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => targetPage),
              )
            : () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tính năng này đang được phát triển!'),
                  duration: Duration(seconds: 1),
                ),
              ),
      ),
    );
  }
}
