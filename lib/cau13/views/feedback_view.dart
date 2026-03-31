import 'package:flutter/material.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _feedbackController = TextEditingController();

  final Color _primaryColor = const Color(0xFFF57C00); // Màu cam (Orange)

  @override
  void dispose() {
    _nameController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    // Dù đã có real-time validate, ta vẫn cần check lại khi bấm Submit
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.mark_email_read_rounded, color: Colors.white),
              SizedBox(width: 8),
              Text('Cảm ơn bạn đã gửi góp ý!', style: TextStyle(fontSize: 16)),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      
      // Xóa trắng form sau khi gửi thành công
      _nameController.clear();
      _feedbackController.clear();
    }
  }

  // Cấu hình UI cho các Input
  InputDecoration _buildInputDecoration({required String label, required IconData icon, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      alignLabelWithHint: true, // Dùng cho TextField nhiều dòng để Label nằm ở trên cùng
      labelStyle: TextStyle(color: Colors.grey[700]),
      prefixIcon: Icon(icon, color: _primaryColor),
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: _primaryColor, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red, width: 2)),
      errorStyle: const TextStyle(fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Bài 13: Form Phản Hồi', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // THANH MSSV QUEN THUỘC
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: _primaryColor.withOpacity(0.1),
            child: Text(
              'MSSV: 6451071018',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _primaryColor, letterSpacing: 1.2),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))
                  ],
                ),
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  // ĐIỂM QUAN TRỌNG CỦA BÀI 13: Bật tính năng Validate ngay khi người dùng gõ phím
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: _primaryColor.withOpacity(0.1),
                          child: Icon(Icons.forum_rounded, size: 36, color: _primaryColor),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'CHÚNG TÔI LẮNG NGHE BẠN',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Center(
                        child: Text(
                          'Mọi ý kiến đóng góp của bạn đều giúp ứng dụng trở nên hoàn thiện hơn.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, height: 1.5),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 1. INPUT TÊN
                      TextFormField(
                        controller: _nameController,
                        decoration: _buildInputDecoration(
                          label: 'Tên của bạn',
                          icon: Icons.person_rounded,
                          hint: 'Nhập tên hoặc biệt danh...',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng cho chúng tôi biết tên của bạn';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // 2. INPUT NỘI DUNG GÓP Ý
                      TextFormField(
                        controller: _feedbackController,
                        maxLines: 5, // Mở rộng ô nhập thành 5 dòng
                        keyboardType: TextInputType.multiline,
                        decoration: _buildInputDecoration(
                          label: 'Nội dung góp ý',
                          icon: Icons.edit_note_rounded,
                          hint: 'Chia sẻ trải nghiệm hoặc lỗi bạn gặp phải...',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nội dung góp ý không được để trống';
                          }
                          if (value.trim().length < 10) {
                            return 'Vui lòng nhập ít nhất 10 ký tự để chúng tôi hiểu rõ hơn';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // NÚT GỬI PHẢN HỒI
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _submitFeedback,
                          icon: const Icon(Icons.send_rounded, color: Colors.white),
                          label: const Text('GỬI GÓP Ý', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}